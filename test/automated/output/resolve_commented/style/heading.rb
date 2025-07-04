require_relative '../../../automated_init'

context "Output" do
  context "Resolved Commented Event" do
    context "Style" do
      context "Heading" do
        style = CommentStyle.heading

        text = Controls::Text.example

        commented = Controls::Events::Commented.example(text:, style:)

        context "Styling Enabled" do
          output = Output.new

          output.writer.set_styling

          output.writer.increase_indentation
          comment "Writer indented"

          output.resolve(
            commented,
            Controls::Status.example
          )

          context "Printed" do
            control_text = "  \e[1m#{text}\e[m\n"

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
            commented,
            Controls::Status.example
          )

          context "Printed" do
            control_text =
              "  #{text}\n" +
              "  - - -\n"

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
end
