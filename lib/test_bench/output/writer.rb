module TestBench
  module Output
    class Writer
      def device
        @device ||= Device::Substitute.build
      end
      attr_writer :device

      def tty
        @tty.nil? ? @tty = device_tty? : @tty
      end
      attr_writer :tty
      alias :tty? :tty

      def device_tty?
        device.tty?
      end
    end
  end
end
