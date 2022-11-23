module TestBench
  class Output
    class Writer
      def device
        @device ||= Device::Substitute.build
      end
      attr_writer :device

      def tty?
        device.tty?
      end
    end
  end
end
