require_relative '../../automated_init'

context "Output" do
  context "Configure Receiver" do
    context "Optional Writer Given" do
      receiver = Struct.new(:output).new

      control_writer = Output::Writer.new

      Controls::Output::Example.configure(receiver, writer: control_writer)

      output = receiver.output

      context "Output's Writer" do
        writer = output.writer

        comment writer.class.name

        configured = writer.equal?(control_writer)

        test "Configured" do
          assert(configured)
        end
      end
    end
  end
end
