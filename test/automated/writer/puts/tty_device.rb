require_relative '../../automated_init'

context "Writer" do
  context "Print" do
    context "TTY Device" do
      text = Controls::Text.example

      writer = Output::Writer.new

      writer.styling_policy = Output::Writer::Styling.off
      writer.device.tty!

      context "Put Text" do
        control_text = "#{text}\e[0K\n"

        writer.puts(text)

        written_text = writer.device.written_data

        comment written_text.inspect
        detail "Control Text: #{control_text.inspect}"

        test "Line is cleared" do
          assert(writer.device.written?(control_text))
        end
      end
    end
  end
end
