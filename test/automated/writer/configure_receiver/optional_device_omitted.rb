require_relative '../../automated_init'

context "Writer" do
  context "Configure Receiver" do
    context "Optional Device Omitted" do
      receiver = Struct.new(:writer).new

      Output::Writer.configure(receiver)

      writer = receiver.writer

      context "Device" do
        device = writer.device

        comment device.inspect

        test "Standard output" do
          assert(device == STDOUT)
        end
      end
    end
  end
end
