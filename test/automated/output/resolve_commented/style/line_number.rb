require_relative '../../../automated_init'

context "Output" do
  context "Resolved Commented Event" do
    context "Style" do
      context "Line Number" do
        style = CommentStyle.line_number

        context "Styling Enabled" do
          output = Output.new

          output.writer.set_styling

          output.writer.increase_indentation
          comment "Writer indented"

          text = Controls::Text::NewlineTerminated.example(lines: 2)
          commented = Controls::Events::Commented.example(text:, style:)

          output.resolve(
            commented,
            Controls::Status.example
          )

          context "Printed" do
            control_text =
              "  \e[2m1. \e[22mLine 1\e[m\n" +
              "  \e[2m2. \e[22mLine 2\e[m\n"

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

          text = Controls::Text::NewlineTerminated.example(lines: 2)
          commented = Controls::Events::Commented.example(text:, style:)

          output.resolve(
            commented,
            Controls::Status.example
          )

          context "Printed" do
            control_text =
              "  1. Line 1\n" +
              "  2. Line 2\n"

            comment output.writer.written_text.inspect
            detail "Control Text: #{control_text.inspect}"

            test do
              assert(output.writer.written?(control_text))
            end
          end
        end

        context "Text Spans Many Lines" do
          output = Output.new

          lines = 10

          text = Controls::Text::NewlineTerminated.example(lines:)
          commented = Controls::Events::Commented.example(text:, style:)

          output.resolve(
            commented,
            Controls::Status.example
          )

          written_text = output.writer.written_text
          detail "Printed Text:", written_text

          context "Line markers are left justified" do
            left_justified = written_text.start_with?('1.  ')

            test do
              assert(left_justified)
            end
          end
        end
      end
    end
  end
end
