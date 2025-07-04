require_relative '../automated_init'

context "Styling Selection" do
  [
    [:detect, true, false],
    [:on, true, true],
    [:off, false, false],
    [true, true, true],
    [false, false, false]
  ].each do |styling, control_tty, control_non_tty|
    context "Styling: #{styling.inspect}" do
      context "TTY Device" do
        control_styling = control_tty

        device = Device::Substitute.build
        device.set_tty

        writer = Writer.build(styling:, device:)

        styling_enabled = writer.styling?

        comment styling_enabled.inspect
        detail "Control: #{control_styling.inspect}"

        test do
          assert(styling_enabled == control_styling)
        end
      end

      context "Non-TTY Device" do
        control_styling = control_non_tty

        device = Device::Substitute.build

        writer = Writer.build(styling:, device:)

        styling_enabled = writer.styling?

        comment styling_enabled.inspect
        detail "Control: #{control_styling.inspect}"

        test do
          assert(styling_enabled == control_styling)
        end
      end
    end
  end

  context "Default Styling" do
    writer = Writer.build

    styling = writer.styling?

    comment styling.inspect

    test "Set" do
      refute(styling.nil?)
    end
  end
end
