require_relative '../../automated_init'

context "Writer" do
  context "Style" do
    context "Incorrect Style" do
      style = :incorrect_style

      writer = Output::Writer.new

      test "Is an error" do
        assert_raises(Output::Writer::Style::Error) do
          writer.style(style)
        end
      end
    end
  end
end
