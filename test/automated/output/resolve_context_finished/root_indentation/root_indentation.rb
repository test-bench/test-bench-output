require_relative '../../../automated_init'

context "Output" do
  context "Resolve Context Finished" do
    context "Root Indentation" do
      context_finished = Controls::Events::ContextFinished.example

      status = Controls::Status.example

      context "Styling Enabled" do
        output = Output.new

        output.writer.set_styling

        control_indentation_depth = 1
        output.writer.indentation_depth = control_indentation_depth

        output.resolve(context_finished, status)

        context "Summary is printed" do
          control_text = <<~TEXT
          \e[m
          \e[31mErrors: \e[1m#{status.error_sequence}\e[m
          \e[31mFailures: \e[1m#{status.failure_sequence}\e[m
          \e[33mSkipped: \e[1m#{status.skip_sequence}\e[m
          TEXT

          comment "Printed Text:", output.writer.written_text
          detail "Control Text:", control_text

          test do
            assert(output.writer.written?(control_text))
          end
        end
      end

      context "Styling Disabled" do
        output = Output.new

        control_indentation_depth = 1
        output.writer.indentation_depth = control_indentation_depth

        output.resolve(context_finished, status)

        context "Summary is printed" do
          control_text = <<~TEXT

          Errors: #{status.error_sequence}
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
