require_relative '../../automated_init'

context "Writer" do
  context "Puts" do
    context "Text Omitted" do
      context do
        writer = Output::Writer.new

        writer.puts

        context "Writes newline" do
          written_text = writer.device.written_data
          control_text = "\n"

          comment written_text.inspect
          detail "Control Text: #{control_text.inspect}"

          test do
            assert(writer.written?(control_text))
          end
        end
      end

      context "Styling" do
        writer = Output::Writer.new

        styling_policy = Output::Writer::Styling.on
        writer.styling_policy = styling_policy

        writer.puts

        context "Resets styling, then writes newline" do
          written_text = writer.device.written_data
          control_text = "\e[0m\n"

          comment written_text.inspect
          detail "Control Text: #{control_text.inspect}"

          test do
            assert(writer.written?(control_text))
          end
        end
      end

      context "TTY Device" do
        writer = Output::Writer.new

        writer.device.tty!

        styling_policy = Output::Writer::Styling.off
        writer.styling_policy = styling_policy

        writer.puts

        context "Writes newline" do
          written_text = writer.device.written_data
          control_text = "\e[0K\n"

          comment written_text.inspect
          detail "Control Text: #{control_text.inspect}"

          test "Line is cleared" do
            assert(writer.written?(control_text))
          end
        end
      end
    end
  end
end
