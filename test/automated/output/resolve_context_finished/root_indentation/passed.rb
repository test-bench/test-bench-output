require_relative '../../../automated_init'

context "Output" do
  context "Resolve Context Finished" do
    context "Root Indentation" do
      context "Passed" do
        context_finished = Controls::Events::ContextFinished.example

        status = Controls::Status::Passed.example

        output = Output.new

        control_indentation_depth = 1
        output.writer.indentation_depth = control_indentation_depth

        output.resolve(context_finished, status)

        context "Not printed" do
          detail "Printed Text: #{output.writer.written_text.inspect}"

          test do
            refute(output.writer.written?)
          end
        end
      end
    end
  end
end
