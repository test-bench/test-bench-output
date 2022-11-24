module TestBench
  class Output
    class Writer
      attr_accessor :peer

      def device
        @device ||= Device::Substitute.build
      end
      attr_writer :device

      def alternate_device
        @alternate_device ||= Device::Substitute.build
      end
      attr_writer :alternate_device

      def styling_policy
        @styling_policy ||= Styling.default
      end
      alias :styling :styling_policy
      attr_writer :styling_policy

      def digest
        @digest ||= Digest.new
      end
      attr_writer :digest

      def sequence
        @sequence ||= 0
      end
      attr_writer :sequence

      def column_sequence
        @column_sequence ||= 0
      end
      attr_writer :column_sequence

      def indentation_depth
        @indentation_depth ||= 0
      end
      attr_writer :indentation_depth

      def buffer
        @buffer ||= Buffer.new
      end
      attr_writer :buffer

      def sync
        @sync.nil? ? @sync = true : @sync
      end

      def self.follow(previous_writer)
        device = previous_writer

        alternate_device = previous_writer.peer
        alternate_device ||= Device::Null.build

        previous_digest = previous_writer.digest
        digest = previous_digest.clone

        writer = new
        writer.sync = false
        writer.device = device
        writer.alternate_device = alternate_device
        writer.styling_policy = previous_writer.styling_policy
        writer.digest = digest
        writer.sequence = previous_writer.sequence
        writer.column_sequence = previous_writer.column_sequence
        writer.indentation_depth = previous_writer.indentation_depth
        writer.digest = previous_writer.digest.clone
        writer
      end

      def puts(text=nil)
        if column_sequence.zero?
          indent
        end

        if not text.nil?
          text = text.chomp

          print(text)
        end

        style(:reset)

        if tty?
          write("\e[0K")
        end

        write("\n")

        self.column_sequence = 0
      end

      def style(style, *additional_styles)
        styles = [style, *additional_styles]

        control_codes = styles.map do |style|
          Style.control_code(style)
        end

        if styling?
          write("\e[#{control_codes.join(';')}m")
        end

        self
      end

      def indent
        indentation = '  ' * indentation_depth

        print(indentation)
      end

      def print(text)
        text = text.dump[1...-1]

        self.column_sequence += text.length

        write(text)

        self
      end

      def write(data)
        if sync
          device.write(data)
          alternate_device.write(data)

          bytes_written = data.bytesize
        else
          bytes_written = buffer.receive(data)
        end

        self.sequence += bytes_written

        data = data[0...bytes_written]
        digest.update(data)

        bytes_written
      end

      def tty?
        device.tty?
      end

      def flush
        buffer.flush(device, alternate_device)
      end

      def sync=(sync)
        @sync = sync

        if sync
          flush
        end
      end

      def written?(data=nil)
        if data.nil?
          sequence > 0
        else
          digest.digest?(data)
        end
      end

      def current?(sequence)
        sequence >= self.sequence
      end

      def increase_indentation
        self.indentation_depth += 1
      end
      alias :indent! :increase_indentation

      def decrease_indentation
        self.indentation_depth -= 1
      end
      alias :deindent! :decrease_indentation

      def follows?(other_writer)
        if sequence < other_writer.sequence
          false
        elsif device == other_writer
          true
        elsif device == other_writer.peer
          true
        else
          false
        end
      end

      def styling?
        Styling.styling?(styling_policy, device.tty?)
      end

      module Styling
        Error = Class.new(RuntimeError)

        def self.styling?(policy, console)
          case policy
          when on
            true
          when off
            false
          when detect
            console ? true : false
          else
            raise Error, "Unknown styling policy #{policy.inspect}"
          end
        end

        def self.on = :on
        def self.off = :off
        def self.detect = :detect

        def self.default
          policy = ENV.fetch('TEST_BENCH_OUTPUT_STYLING') do
            return default!
          end

          policy.to_sym
        end

        def self.default!
          :detect
        end
      end
    end
  end
end
