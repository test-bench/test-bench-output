require_relative '../../automated_init'

context "Writer" do
  context "Puts" do
    writer = Output::Writer.new

    text = Controls::Text.example
    writer.puts(text)

    context "Writes text, then newline" do
      written_text = writer.device.written_data
      control_text = "#{text}\n"

      comment written_text.inspect
      detail "Control Text: #{control_text.inspect}"

      test do
        assert(writer.written?(control_text))
      end
    end
  end
end
