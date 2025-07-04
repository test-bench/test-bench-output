require_relative '../automated_init'

context "Device" do
  context "Configure Receiever" do
    receiver = Struct.new(:device).new

    context "Given a Device Instance" do
      device = Device.new

      Device.configure(receiver, device:)

      configured = receiver.device == device

      test "Configures receiver with the given instance" do
        assert(configured)
      end
    end

    context "Optional Device Omitted" do
      Device.configure(receiver)

      configured = receiver.device.raw_device == Device.build.raw_device

      test "Configures receiver" do
        assert(configured)
      end
    end
  end
end
