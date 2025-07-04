require_relative '../../automated_init'

context "Output" do
  context "Resolve File Executed" do
    context "No Result" do
      file_executed = Controls::Events::FileExecuted::Inert.example

      context "Styling Enabled" do
        output = Output.new

        output.writer.set_styling

        output.resolve(
          file_executed,
          Controls::Status.example
        )

        context "Printed" do
          control_text = "\e[2;3m(no tests)\e[m\n\e[m\n"

          comment "Printed Text:", output.writer.written_text
          detail "Control Text:", control_text

          test do
            assert(output.writer.written?(control_text))
          end
        end
      end

      context "Styling Disabled" do
        output = Output.new

        output.resolve(
          file_executed,
          Controls::Status.example
        )

        context "Printed" do
          control_text = "(no tests)\n\n"

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
