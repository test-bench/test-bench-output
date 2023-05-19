require_relative '../../automated_init'

context "Writer" do
  context "Configure Receiver" do
    attr_name = :writer
    comment "Default Attribute Name: #{attr_name.inspect}"

    receiver = Struct.new(attr_name).new

    device = Controls::Device.example
    styling = Controls::Styling.random

    Output::Writer.configure(receiver, device:, styling:)

    writer = receiver.public_send(attr_name)

    context "Configured" do
      comment writer.class.name

      configured = writer.instance_of?(Output::Writer) &&
        writer.device == device &&
        writer.styling == styling &&
        writer.buffer.limit.zero?

      test do
        assert(configured)
      end
    end
  end
end
