require_relative '../automated_init'

context "Device" do
  context "Raw Device Selection" do
    context "Standard Output" do
      target_device = :stdout

      device = Device.build(target_device)

      raw_device = device.raw_device

      test do
        assert(raw_device == STDOUT)
      end
    end

    context "Standard Error" do
      target_device = :stderr

      device = Device.build(target_device)

      raw_device = device.raw_device

      test do
        assert(raw_device == STDERR)
      end
    end

    context "Null Device" do
      target_device = :null

      device = Device.build(target_device)

      raw_device = device.raw_device

      test do
        assert(raw_device == Device::Null.instance)
      end
    end

    context "Other Symbol" do
      target_device = :other_symbol

      test "Is an error" do
        assert_raises(Device::Error) do
          Device.build(target_device)
        end
      end
    end

    context "Any Object" do
      target_device = Object.new

      device = Device.build(target_device)

      raw_device = device.raw_device

      test do
        assert(raw_device == target_device)
      end
    end
  end
end
