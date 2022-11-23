require_relative '../../automated_init'

context "Writer" do
  context "Style" do
    context "Multiple Styles" do
      style_1 = Controls::Style.example
      style_2 = Controls::Style.other_example

      control_code_1 = Controls::Style::Code.example
      control_code_2 = Controls::Style::Code.other_example

      writer = Output::Writer.new

      writer.styling_policy = Output::Writer::Styling.on

      writer.style(style_1, style_2)

      context "Text is written" do
        written_text = writer.device.written_data
        control_text = "\e[#{control_code_1};#{control_code_2}m"

        comment written_text.inspect
        detail "Control Text: #{control_text.inspect}"

        test do
          assert(writer.written?(control_text))
        end
      end
    end
  end
end
