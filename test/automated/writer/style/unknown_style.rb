require_relative '../../automated_init'

context "Output" do
  context "Writer" do
    context "Style" do
      context "Unknown Style" do
        style = :unknown

        writer = Output::Writer.new

        test "Raises an error" do
          assert_raises(Output::Writer::Style::Error) do
            writer.style(style)
          end
        end
      end
    end
  end
end
