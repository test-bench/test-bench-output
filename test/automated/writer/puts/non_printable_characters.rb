require_relative '../../automated_init'

context "Writer" do
  context "Print" do
    context "Non-Printable Characters" do
      writer = Output::Writer.new

      text = Controls::Text::NonPrintableCharacters.example

      context "Put Text" do
        control_text = Controls::Text::NonPrintableCharacters::Escaped.example
        control_text = "#{control_text}\n"

        writer.puts(text)

        written_text = writer.device.written_data

        comment written_text.inspect
        detail "Control Text: #{control_text.inspect}"

        test "Escaped" do
          assert(writer.device.written?(control_text))
        end
      end
    end
  end
end
