module TestBench
  module Output
    class Writer
      def device
        @device ||= Device::Substitute.build
      end
      attr_writer :device

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
