require_relative '../automated_init'

context "Output" do
  context "Resolve Failed Event" do
    message = Controls::Events::Failed.message
    failed = Controls::Events::Failed.example(message:)

    context "Styling Enabled" do
      output = Output.new

      output.writer.set_styling

      output.writer.increase_indentation
      comment "Writer indented"

      output.resolve(
        failed,
        Controls::Status.example
      )

      context "Printed" do
        control_text = "  \e[31m#{message}\e[m\n"

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
        failed,
        Controls::Status.example
      )

      context "Printed" do
        control_text = "  #{message}\n"

        comment output.writer.written_text.inspect
        detail "Control Text: #{control_text.inspect}"

        test do
          assert(output.writer.written?(control_text))
        end
      end
    end
  end
end
