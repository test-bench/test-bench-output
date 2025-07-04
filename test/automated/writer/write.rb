require_relative '../automated_init'

context "Writer" do
  context "Write" do
    writer = Output::Writer.new

    text = Controls::Text.example

    bytes_written = writer.write(text)

    context "Device" do
      device = writer.device

      comment "Written Text: #{device.written_text.inspect}"
      detail "Control Text: #{text.inspect}"

      test "Text is written" do
        assert(device.written?(text))
      end
    end

    context "Bytes Written" do
      control_bytes_written = text.bytesize

      comment bytes_written.inspect
      detail "Control: #{control_bytes_written.inspect}"

      test do
        assert(bytes_written == control_bytes_written)
      end
    end
  end
end
