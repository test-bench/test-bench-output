require_relative '../../automated_init'

context "Writer" do
  context "Puts" do
    context "Newline Included" do
      writer = Output::Writer.new

      control_text = "Some text\n"
      writer.puts(control_text)

      context "Doesn't write an additional newline" do
        written_text = writer.device.written_data

        comment written_text.inspect
        detail "Control Text: #{control_text.inspect}"

        test do
          assert(writer.written?(control_text))
        end
      end
    end
  end
end
