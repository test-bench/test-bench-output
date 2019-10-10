require_relative '../../automated_init'

context "Writer" do
  context "Configure Receiver" do
    context "Optional Writer Given" do
      receiver = Struct.new(:writer).new

      control_writer = Output::Writer.new

      Output::Writer.configure(receiver, writer: control_writer)

      context "Receiver's Writer" do
        writer = receiver.writer

        comment writer.class.name

        configured = writer.equal?(control_writer)

        test "Configured" do
          assert(configured)
        end
      end
    end
  end
end
