module TestBench
  module Output
    class Writer
      def device
        @device ||= Device::Substitute.build
      end
      attr_writer :device

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

      def buffer
        @buffer ||= Buffer.new
      end
      attr_writer :buffer

      def sync
        @sync.nil? ? @sync = true : @sync
      end

      def tty
        @tty.nil? ? @tty = device_tty? : @tty
      end
      attr_writer :tty
      alias :tty? :tty

      def print(text)
        self.column_sequence += text.length

        write(text)

        self
      end

      def write(data)
        if sync
          bytes_written = write!(data)
        else
          bytes_written = buffer.receive(data)
        end

        self.sequence += bytes_written

        data = data[0...bytes_written]
        digest.update(data)

        bytes_written
      end

      def write!(data)
        device.write(data)

        data.bytesize
      end

      def device_tty?
        device.tty?
      end

      def flush
        buffer.flush(device)
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

      def styling?
        Styling.styling?(styling_policy, tty?)
      end

      module Styling
        Error = Class.new(RuntimeError)

        def self.styling?(policy, console)
          assure_styling(policy, console)
        end

        def self.assure_styling(policy, console=nil)
          console ||= false

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
