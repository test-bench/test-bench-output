require_relative '../../automated_init'

context "Output" do
  context "Resolve Skipped Event" do
    context "No Message" do
      skipped = Controls::Events::Skipped::NoMessage.example

      context "Styling Enabled" do
        output = Output.new

        output.writer.set_styling

        output.writer.increase_indentation
        comment "Writer indented"

        output.resolve(
          skipped,
          Controls::Status.example
        )

        context "Printed" do
          control_text = "  \e[33mSkipped\e[m\n"

          comment output.writer.written_text.inspect
          detail "Control Text: #{control_text.inspect}"

          test do
            assert(output.writer.written?(control_text))
          end
        end
      end

      context "Styling Disabled" do
        output = Output.new

        output.writer.increase_indentation
        comment "Writer indented"

        output.resolve(
          skipped,
          Controls::Status.example
        )

        context "Printed" do
          control_text = "  Skipped\n"

          comment output.writer.written_text.inspect
          detail "Control Text: #{control_text.inspect}"

          test do
            assert(output.writer.written?(control_text))
          end
        end
      end
    end
  end
end
