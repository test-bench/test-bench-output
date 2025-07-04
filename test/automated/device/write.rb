require_relative '../automated_init'

context "Device" do
  context "Write" do
    device = Device.new

    text = Controls::Text.example

    bytes_written = 0

    bytes_written += device.write(text[0...1])
    bytes_written += device.write(text[1..-1])

    context "Bytes Written" do
      control_bytes_written = text.bytesize

      comment bytes_written.inspect
      detail "Control: #{bytes_written.inspect}"

      test do
        assert(bytes_written == control_bytes_written)
      end
    end

    context "Written Text" do
      written_text = device.raw_device.written_text

      comment written_text.inspect
      detail "Control: #{text.inspect}"

      test do
        assert(written_text == text)
      end
    end
  end
end
