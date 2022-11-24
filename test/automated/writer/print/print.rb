require_relative '../../automated_init'

context "Writer" do
  context "Print" do
    writer = Output::Writer.new

    text = Controls::Text.example

    context "Print Text" do
      writer.print(text)

      written_text = writer.device.written_data

      comment written_text.inspect
      detail "Control Text: #{text.inspect}"

      test "Written" do
        assert(writer.device.written?(text))
      end
    end
  end
end
