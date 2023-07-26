require_relative '../../automated_init'

context "Digest" do
  context "Configure Receiver" do
    context "Optional Attribute Name" do
      attr_name = :some_other_attr
      comment "Attribute Name: #{attr_name.inspect}"

      receiver = Struct.new(attr_name).new

      Output::Digest.configure(receiver, attr_name:)

      context "Receiver's Digest Dependency" do
        digest = receiver.public_send(attr_name)

        configured = !digest.nil?

        test "Configured" do
          assert(configured)
        end
      end
    end
  end
end
