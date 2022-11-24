require_relative '../../automated_init'

context "Writer" do
  context "Print" do
    context "Non-Printable Characters" do
      writer = Output::Writer.new

      text = Controls::Text::NonPrintableCharacters.example

      context "Print Text" do
        control_text = Controls::Text::NonPrintableCharacters::Escaped.example

        writer.print(text)

        written_text = writer.device.written_data

        comment written_text.inspect
        detail "Control Text: #{control_text.inspect}"

        test "Escaped" do
          assert(writer.device.written?(written_text))
        end
      end
    end
  end
end
