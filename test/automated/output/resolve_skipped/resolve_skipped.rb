require_relative '../../automated_init'

context "Output" do
  context "Resolve Skipped Event" do
    message = Controls::Events::Skipped.message
    skipped = Controls::Events::Skipped.example(message:)

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
        control_text = "  \e[33m#{message}\e[m\n"

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
        control_text = "  #{message} (skipped)\n"

        comment output.writer.written_text.inspect
        detail "Control Text: #{control_text.inspect}"

        test do
          assert(output.writer.written?(control_text))
        end
      end
    end
  end
end
