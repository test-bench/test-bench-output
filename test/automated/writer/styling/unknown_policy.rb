require_relative '../../automated_init'

context "Writer" do
  context "Styling Predicate" do
    context "Unknown Policy" do
      styling_policy = :unknown

      writer = Output::Writer.new

      writer.styling_policy = styling_policy

      test "Is an error" do
        assert_raises(Output::Writer::Styling::Error) do
          writer.styling?
        end
      end
    end
  end
end
