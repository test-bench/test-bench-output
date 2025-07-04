require_relative '../automated_init'

context "Device" do
  context "TTY Predicate" do
    context "Affirmative" do
      context "Raw Device Is A TTY" do
        device = Device.new

        raw_device = Device::Substitute.build
        raw_device.set_tty

        device.raw_device = raw_device

        tty = device.tty?

        test do
          assert(tty)
        end
      end
    end

    context "Negative" do
      context "Raw Device Isn't A TTY" do
        device = Device.new

        raw_device = Device::Substitute.build
        device.raw_device = raw_device

        tty = device.tty?

        test do
          refute(tty)
        end
      end
    end
  end
end
