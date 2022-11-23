require_relative '../../automated_init'

context "Writer" do
  context "Style" do
    context "Successive Invocations" do
      style = Controls::Style.example
      style_code = Controls::Style::Code.example

      writer = Output::Writer.new
      writer.styling_policy = Output::Writer::Styling.on

      writer
        .style(style)
        .style(style)

      context "Control sequences are written" do
        written_text = writer.device.written_data
        control_text = "\e[#{style_code}m\e[#{style_code}m"

        comment written_text.inspect
        detail "Control Text: #{control_text.inspect}"

        test do
          assert(writer.written?(control_text))
        end
      end
    end
  end
end
