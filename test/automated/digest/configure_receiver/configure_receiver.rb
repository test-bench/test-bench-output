require_relative '../../automated_init'

context "Digest" do
  context "Configure Receiver" do
    attr_name = :digest
    comment "Default Attribute Name: #{attr_name.inspect}"

    receiver = Struct.new(attr_name).new

    Output::Digest.configure(receiver)

    context "Receiver's Digest Dependency" do
      digest = receiver.public_send(attr_name)

      inert = digest.instance_of?(Output::Digest::Null)

      test "Inert implementation" do
        assert(inert)
      end
    end
  end
end
