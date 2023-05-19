require_relative '../../automated_init'

context "Writer" do
  context "Style" do
    style = Controls::Style.example
    style_code = Controls::Style::Code.example

    context "Styling Enabled" do
      styling_policy = Output::Writer::Styling.on

      writer = Output::Writer.new
      writer.styling_policy = styling_policy

      writer.style(style)

      context "Writes a control sequence" do
        written_text = writer.device.written_data
        control_text = "\e[#{style_code}m"

        comment written_text.inspect
        detail "Control Text: #{control_text.inspect}"

        test do
          assert(writer.written?(control_text))
        end
      end
    end

    context "Styling Disabled" do
      styling_policy = Output::Writer::Styling.off

      writer = Output::Writer.new
      writer.styling_policy = styling_policy

      writer.style(style)

      test "No text written" do
        refute(writer.written?)
      end
    end
  end
end
