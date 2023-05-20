require_relative '../../automated_init'

context "Output" do
  context "Configure Receiver" do
    context "Optional Attribute Name Given" do
      attr_name = :some_other_attr
      comment "Attribute Name: #{attr_name.inspect}"

      receiver = Struct.new(attr_name).new

      Controls::Output::Example.configure(receiver, attr_name:)

      output = receiver.public_send(attr_name)

      test "Configured" do
        assert(output.instance_of?(Controls::Output::Example))
      end
    end
  end
end
