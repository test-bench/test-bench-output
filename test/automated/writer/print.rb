require_relative '../automated_init'

context "Writer" do
  context "Print" do
    writer = Output::Writer.new

    control_text = Controls::Text.example

    writer.
      print(control_text).
      print(' ').
      print(control_text)

    context "Written Text" do
      control_text = "#{control_text} #{control_text}"

      comment "Written Text: #{writer.device.written_text.inspect}"
      detail "Control Text: #{control_text}"

      test do
        assert(writer.device.written?(control_text))
      end
    end
  end
end
