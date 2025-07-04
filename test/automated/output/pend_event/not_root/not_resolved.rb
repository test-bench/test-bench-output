require_relative '../../../automated_init'

context "Output" do
  context "Pend Event" do
    context "Not Root" do
      context "Event Isn't Resolved" do
        output = Output.new

        branch = Branch.new
        output.branches << branch

        output.pend(Controls::Events::Commented.example)

        detail "Printed Text: #{output.writer.written_text.inspect}"

        resolved = output.writer.written?

        test do
          refute(resolved)
        end
      end
    end
  end
end
