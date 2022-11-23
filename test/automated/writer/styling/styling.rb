require_relative '../../automated_init'

context "Writer" do
  context "Styling Predicate" do
    [
      ["On", Output::Writer::Styling.on, true, true],
      ["Off", Output::Writer::Styling.off, false, false],
      ["Detect", Output::Writer::Styling.detect, true, false]
    ].each do |title, styling_policy, interactive_control_value, non_interactive_control_value|
      context "Policy: #{title}" do
        writer = Output::Writer.new

        writer.styling_policy = styling_policy

        context "Device Is Associated With a Terminal" do
          writer.tty = true

          styling = writer.styling?

          comment styling.inspect
          detail "Control: #{interactive_control_value.inspect}"

          test do
            assert(styling == interactive_control_value)
          end
        end

        context "Device Isn't Associated With a Terminal" do
          writer.tty = false

          styling = writer.styling?

          comment styling.inspect
          detail "Control: #{non_interactive_control_value.inspect}"

          test do
            assert(styling == non_interactive_control_value)
          end
        end
      end
    end
  end
end
