require_relative '../../../automated_init'

context "Output" do
  context "Pend Event" do
    context "Root" do
      context "Event Is Resolved" do
        output = Output.new

        text = Controls::Text.example

        event = Controls::Events::Commented.example(text:)
        output.pend(event)

        control_text = "#{text}\n"

        detail "Printed Text: #{output.writer.written_text.inspect}"
        detail "Control Text: #{control_text.inspect}"

        resolved = output.writer.written?(control_text)

        test do
          assert(resolved)
        end
      end
    end
  end
end
