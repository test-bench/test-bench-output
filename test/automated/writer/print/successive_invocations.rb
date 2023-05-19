require_relative '../../automated_init'

context "Writer" do
  context "Print" do
    context "Successive Invocations" do
      writer = Output::Writer.new

      text = Controls::Text.example

      writer
        .print(text[0...1])
        .print(text[1..-1])

      written_text = writer.device.written_data

      comment written_text.inspect
      detail "Control Text: #{text.inspect}"

      test "Text is written" do
        assert(writer.written?('Some text'))
      end
    end
  end
end
