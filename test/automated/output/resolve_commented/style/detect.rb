require_relative '../../../automated_init'

context "Output" do
  context "Resolved Commented Event" do
    context "Style" do
      context "Detect" do
        style = CommentStyle.detect

        context "Newline Terminated Text" do
          text = Controls::Text::NewlineTerminated.example(lines: 2)

          commented = Controls::Events::Commented.example(text:, style:)

          output = Output.new

          output.resolve(
            commented,
            Controls::Status.example
          )

          context "Block indentation" do
            control_text = <<~TEXT
            > Line 1
            > Line 2
            TEXT

            comment "Printed Text: #{output.writer.written_text.inspect}"
            detail "Control Text: #{control_text.inspect}"

            test do
              assert(output.writer.written?(control_text))
            end
          end
        end

        context "Not Newline Terminated Text" do
          text = Controls::Text::NewlineTerminated.example(lines: 2)
          text.chomp!

          commented = Controls::Events::Commented.example(text:, style:)

          output = Output.new

          output.writer.increase_indentation

          output.resolve(
            commented,
            Controls::Status.example
          )

          context "Normal indentation" do
            control_text = <<~TEXT
              Line 1
            Line 2
            TEXT

            comment "Printed Text: #{output.writer.written_text.inspect}"
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
