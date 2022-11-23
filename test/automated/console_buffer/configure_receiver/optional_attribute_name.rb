require_relative '../../automated_init'

context "Console Buffer" do
  context "Configure Receiver" do
    context "Optional Attribute Name Given" do
      attr_name = :some_attr
      comment "Attribute Name: #{attr_name.inspect}"

      receiver =  Struct.new(attr_name).new

      Output::Writer::Buffer::Console.configure(receiver, attr_name:)

      context "Buffer" do
        buffer = receiver.public_send(attr_name)

        comment buffer.class.name

        configured = buffer.instance_of?(Output::Writer::Buffer::Console)

        test "Configured" do
          assert(configured)
        end
      end
    end
  end
end
