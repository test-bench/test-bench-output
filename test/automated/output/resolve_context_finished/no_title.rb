require_relative '../../automated_init'

context "Output" do
  context "Resolve Context Finished" do
    context "No Title" do
      context_finished = Controls::Events::ContextFinished::NoTitle.example

      output = Output.new

      control_indentation_depth = 11
      output.writer.indentation_depth = control_indentation_depth

      output.resolve(
        context_finished,
        Controls::Status.example
      )

      context "Writer" do
        deindented = output.writer.indentation_depth < control_indentation_depth

        test "Not deindented" do
          refute(deindented)
        end
      end

      context "Not printed" do
        detail "Printed Text: #{output.writer.written_text.inspect}"

        test do
          refute(output.writer.written?)
        end
      end
    end
  end
end
