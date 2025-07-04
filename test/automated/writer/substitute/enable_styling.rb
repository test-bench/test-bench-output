require_relative '../../automated_init'

context "Writer Substitute" do
  context "Enable Styling" do
    style = Controls::Style.example
    style_code = Controls::Style.code

    context "Enabled" do
      substitute = Output::Writer::Substitute.build

      substitute.set_styling

      substitute.style(style)

      context "Control sequence is recorded" do
        control_text = "\e[#{style_code}m"

        comment substitute.written_text.inspect
        detail "Control Text: #{control_text.inspect}"

        test do
          assert(substitute.written?(control_text))
        end
      end
    end

    context "Not Enabled" do
      substitute = Output::Writer::Substitute.build

      substitute.style(style)

      detail substitute.written_text.inspect

      test "No text written" do
        refute(substitute.written?)
      end
    end
  end
end
