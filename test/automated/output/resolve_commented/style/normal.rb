require_relative '../../../automated_init'

context "Output" do
  context "Resolved Commented Event" do
    context "Style" do
      context "Normal" do
        style = CommentStyle.normal

        text = Controls::Text.example

        commented = Controls::Events::Commented.example(text:, style:)

        output = Output.new

        output.writer.increase_indentation
        comment "Writer indented"

        output.resolve(
          commented,
          Controls::Status.example
        )

        context "Printed" do
          control_text = "  #{text}\n"

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
