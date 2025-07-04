require_relative '../../automated_init'

context "Output" do
  context "Resolve Context Finished" do
    context_finished = Controls::Events::ContextFinished.example

    output = Output.new

    control_indentation_depth = 11
    output.writer.indentation_depth = control_indentation_depth

    output.resolve(
      context_finished,
      Controls::Status.example
    )

    context "Not printed" do
      detail "Printed Text: #{output.writer.written_text.inspect}"

      test do
        refute(output.writer.written?)
      end
    end

    context "Writer" do
      deindented = output.writer.indentation_depth < control_indentation_depth

      test "Deindented" do
        assert(deindented)
      end
    end
  end
end
