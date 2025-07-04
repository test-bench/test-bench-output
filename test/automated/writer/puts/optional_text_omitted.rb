require_relative '../../automated_init'

context "Writer" do
  context "Puts" do
    context "Optional Text Omitted" do
      context "Styling Enabled" do
        writer = Output::Writer.new

        writer.styling = true

        writer.puts

        context "Resets styles and writes newline" do
          control_text = "\e[m\n"

          comment "Written Text: #{writer.device.written_text.inspect}"
          detail "Control Text: #{control_text.inspect}"

          test do
            assert(writer.device.written?(control_text))
          end
        end
      end

      context "Styling Disabled" do
        writer = Output::Writer.new

        writer.styling = false

        writer.puts

        context "Writes newline" do
          control_text = "\n"

          comment "Written Text: #{writer.device.written_text.inspect}"
          detail "Control Text: #{control_text.inspect}"

          test do
            assert(writer.device.written?(control_text))
          end
        end
      end
    end
  end
end
