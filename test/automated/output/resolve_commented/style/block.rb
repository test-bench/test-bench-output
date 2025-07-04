require_relative '../../../automated_init'

context "Output" do
  context "Resolved Commented Event" do
    context "Style" do
      context "Block" do
        style = CommentStyle.block

        text = Controls::Text::NewlineTerminated.example(lines: 2)

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
            control_text =
              "  \e[7m \e[27m Line 1\e[m\n" +
              "  \e[7m \e[27m Line 2\e[m\n"

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
              "  > Line 1\n" +
              "  > Line 2\n"

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
