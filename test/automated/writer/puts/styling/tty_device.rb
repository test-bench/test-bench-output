require_relative '../../../automated_init'

context "Writer" do
  context "Print" do
    context "Styling" do
      context "TTY Device" do
        writer = Output::Writer.new

        writer.device.tty!

        styling_policy = Output::Writer::Styling.on
        writer.styling_policy = styling_policy

        context "Put Text" do
          text = Controls::Text.example

          control_text = "#{text}\e[0m\e[0K\n"

          writer.puts(text)

          written_text = writer.device.written_data

          comment written_text.inspect
          detail "Control Text: #{control_text.inspect}"

          test "Styling is reset" do
            assert(writer.device.written?(control_text))
          end
        end
      end
    end
  end
end
