require_relative '../../automated_init'

context "Console Buffer" do
  context "Configure Receiver" do
    context "Device" do
      receiver =  Struct.new(:buffer).new

      context "Associated With a Terminal" do
        device = Controls::Device::TTY.example

        Output::Writer::Buffer::Console.configure(receiver, device:)

        buffer = receiver.buffer

        context "Buffer's Device" do
          buffer_device = buffer.device

          test "Is the device" do
            assert(buffer_device == device)
          end
        end
      end

      context "Not Associated With a Terminal" do
        device = Controls::Device::TTY::Non.example

        Output::Writer::Buffer::Console.configure(receiver, device:)

        buffer = receiver.buffer

        context "Buffer's Device" do
          buffer_device = buffer.device

          test "Null device" do
            assert(buffer_device.instance_of?(Output::Device::Null))
          end
        end
      end
    end
  end
end
