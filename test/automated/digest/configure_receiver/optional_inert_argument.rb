require_relative '../../automated_init'

context "Digest" do
  context "Configure Receiver" do
    context "Optional Inert Argument" do
      receiver_class = Struct.new(:digest)

      context "Inert" do
        receiver = receiver_class.new

        Output::Digest.configure(receiver, inert: true)

        context "Receiver's Digest Dependency" do
          digest = receiver.digest

          inert = digest.instance_of?(Output::Digest::Null)

          test do
            assert(inert)
          end
        end
      end

      context "Not Inert" do
        receiver = receiver_class.new

        Output::Digest.configure(receiver, inert: false)

        context "Receiver's Digest Dependency" do
          digest = receiver.digest

          not_inert = digest.instance_of?(Output::Digest)

          test do
            assert(not_inert)
          end
        end
      end
    end
  end
end
