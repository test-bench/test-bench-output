require_relative '../../../automated_init'

context "Output" do
  context "Resolved Commented Event" do
    context "Style" do
      context "Raw" do
        style = CommentStyle.raw

        text = Controls::Text.example

        commented = Controls::Events::Commented.example(text:, style:)

        control_text = "#{text}\n"

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
