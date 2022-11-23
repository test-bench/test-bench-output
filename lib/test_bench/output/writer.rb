module TestBench
  class Output
    class Writer
      def device
        @device ||= Device::Substitute.build
      end
      attr_writer :device

      def alternate_device
        @alternate_device ||= Device::Substitute.build
      end
      attr_writer :alternate_device

      def buffer
        @buffer ||= Buffer.new
      end
      attr_writer :buffer

      def tty?
        device.tty?
      end

      def flush
        buffer.flush(device, alternate_device)
      end
    end
  end
end
