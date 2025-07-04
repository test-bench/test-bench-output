require_relative '../../automated_init'

context "Writer" do
  context "Style" do
    context "Multiple Styles" do
      style = Controls::Style.example
      control_code = Controls::Style.code

      other_style = Controls::Style::Other.example
      other_control_code = Controls::Style::Other.code

      writer = Output::Writer.new

      writer.styling = true

      writer.style(style, other_style)

      context "Control codes are combined into one sequence" do
        control_text = "\e[#{control_code};#{other_control_code}m"

        comment "Written Text: #{writer.device.written_text.inspect}"
        detail "Control Text: #{control_text.inspect}"

        test do
          assert(writer.device.written?(control_text))
        end
      end
    end
  end
end
