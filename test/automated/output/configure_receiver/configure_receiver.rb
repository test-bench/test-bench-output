require_relative '../../automated_init'

context "Output" do
  context "Configure Receiver" do
    attr_name = :output
    comment "Default Attribute Name: #{attr_name.inspect}"

    receiver = Struct.new(attr_name).new

    device = Controls::Device.example
    styling = Controls::Styling.random

    Controls::Output::Example.configure(receiver, device:, styling:)

    output = receiver.public_send(attr_name)

    test! "Configured" do
      assert(output.instance_of?(Controls::Output::Example))
    end

    context "Writer Dependency" do
      writer = output.writer

      context "Configured" do
        comment writer.class.name

        configured = writer.instance_of?(Output::Writer) &&
          writer.device == device &&
          writer.styling == styling

        test do
          assert(configured)
        end
      end
    end
  end
end
