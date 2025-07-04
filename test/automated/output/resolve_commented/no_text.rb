require_relative '../../automated_init'

context "Output" do
  context "Resolved Commented Event" do
    test "No Text" do
      text = ''

      context "Styles" do
        [
          [CommentStyle.normal, "  \e[2;3m(empty)\e[m\n", "  (empty)\n"],
          [CommentStyle.heading, "  \e[2;3m(no heading)\e[m\n", "  (no heading)\n  - - -\n"],
          [CommentStyle.block, "  \e[2;3m(empty)\e[m\n", "  (empty)\n"],
          [CommentStyle.line_number, "  \e[2;3m(empty)\e[m\n", "  (empty)\n"],
          [CommentStyle.raw, "\n", "\n"]
        ].each do |style, control_styled_text, control_unstyled_text|

          commented = Controls::Events::Commented.example(text:, style:)

          context_title = style.to_s.capitalize

          context "#{context_title}" do
            context "Styling Enabled" do
              control_text = control_styled_text

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
              control_text = control_unstyled_text

              output = Output.new

              output.writer.increase_indentation

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
  end
end
