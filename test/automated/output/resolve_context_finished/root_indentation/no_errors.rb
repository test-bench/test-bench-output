require_relative '../../../automated_init'

context "Output" do
  context "Resolve Context Finished" do
    context "Root Indentation" do
      context "No Errors" do
        context_finished = Controls::Events::ContextFinished.example

        status = Controls::Status.example
        status.error_sequence = 0

        output = Output.new

        control_indentation_depth = 1
        output.writer.indentation_depth = control_indentation_depth

        output.resolve(context_finished, status)

        context "Errors are omitted from summary" do
          control_text = <<~TEXT

          Failures: #{status.failure_sequence}
          Skipped: #{status.skip_sequence}
          TEXT

          comment "Printed Text:", output.writer.written_text
          detail "Control Text:", control_text

          test do
            assert(output.writer.written?(control_text))
          end
        end
      end
    end
  end
end
