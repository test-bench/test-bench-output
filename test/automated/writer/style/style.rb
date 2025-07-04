require_relative '../../automated_init'

context "Writer" do
  context "Style" do
    style = Controls::Style.example
    style_code = Controls::Style::Code.example

    context "Styling Enabled" do
      writer = Output::Writer.new

      writer.styling = true

      writer.
        style(style).
        style(style)

      context "Control codes are written" do
        control_text = "\e[#{style_code}m\e[#{style_code}m"

        comment "Written Text: #{writer.device.written_text.inspect}"
        detail "Control Text: #{control_text.inspect}"

        test do
          assert(writer.device.written?(control_text))
        end
      end
    end

    context "Styling Disabled" do
      writer = Output::Writer.new

      writer.styling = false

      writer.style(style)

      test "Control codes aren't written" do
        refute(writer.device.written?)
      end
    end
  end
end
