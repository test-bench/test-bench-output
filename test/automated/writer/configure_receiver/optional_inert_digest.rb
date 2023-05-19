require_relative '../../automated_init'

context "Writer" do
  context "Configure Receiver" do
    context "Optional Inert Digest Argument" do
      receiver_class = Struct.new(:writer)

      context "Inert" do
        receiver = receiver_class.new

        Output::Writer.configure(receiver, inert_digest: true)

        writer = receiver.writer

        context "Digest" do
          digest = writer.digest

          inert = digest.instance_of?(Output::Digest::Null)

          test do
            assert(inert)
          end
        end
      end

      context "Not Inert" do
        receiver = receiver_class.new

        Output::Writer.configure(receiver, inert_digest: false)

        writer = receiver.writer

        context "Digest" do
          digest = writer.digest

          not_inert = digest.instance_of?(Output::Digest)

          test do
            assert(not_inert)
          end
        end
      end
    end
  end
end
