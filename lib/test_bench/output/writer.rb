module TestBench
  module Output
    class Writer
      def device
        @device ||= Device::Substitute.build
      end
      attr_writer :device

      def digest
        @digest ||= Digest.new
      end
      attr_writer :digest

      def sequence
        @sequence ||= 0
      end
      attr_writer :sequence

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
    end
  end
end
