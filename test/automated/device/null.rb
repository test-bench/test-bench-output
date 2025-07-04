require_relative '../automated_init'

context "Null Device" do
  device = Device::Null.instance

  context "Write" do
    text = Controls::Text.example

    bytes_written = device.write(text)

    context "Bytes Written" do
      control_bytes_written = text.bytesize

      comment bytes_written.inspect
      detail "Control: #{bytes_written.inspect}"

      test do
        assert(bytes_written == control_bytes_written)
      end
    end
  end

  context "TTY Predicate" do
    tty = device.tty?

    test "Not a TTY" do
      refute(tty)
    end
  end
end
