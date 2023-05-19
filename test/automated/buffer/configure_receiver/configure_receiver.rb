require_relative '../../automated_init'

context "Buffer" do
  context "Configure Receiver" do
    attr_name = :buffer
    comment "Default Attribute Name: #{attr_name.inspect}"

    receiver = Struct.new(attr_name).new

    Output::Writer::Buffer.configure(receiver)

    buffer = receiver.public_send(attr_name)

    context "Configured" do
      comment buffer.class.name

      configured = buffer.instance_of?(Output::Writer::Buffer) &&
        buffer.limit.zero?

      test do
        assert(configured)
      end
    end
  end
end
