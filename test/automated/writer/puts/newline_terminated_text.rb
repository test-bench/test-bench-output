require_relative '../../automated_init'

context "Writer" do
  context "Puts" do
    context "Text Is Terminated By A Newline" do
      writer = Output::Writer.new

      control_text = Controls::Text::NewlineTerminated.example
      writer.puts(control_text)

      context "Doesn't write an additional newline" do
        comment "Written Text: #{writer.device.written_text.inspect}"
        detail "Control Text: #{control_text.inspect}"

        test do
          assert(writer.device.written?(control_text))
        end
      end
    end
  end
end
