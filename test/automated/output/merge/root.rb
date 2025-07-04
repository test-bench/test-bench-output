require_relative '../../automated_init'

context "Output" do
  context "Merge" do
    context "Root" do
      output = Output.new

      branch = output.branch(Controls::Event.example)
      branch.status = Controls::Status::Aborted.example

      test_title = Controls::Events::TestStarted.title
      control_event = Controls::Events::TestStarted.example(title: test_title)
      output.merge(control_event)

      context "Pended events are resolved" do
        control_text = "#{test_title} (aborted)\n"

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
