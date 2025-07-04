require_relative '../automated_init'

context "Get Output" do
  context "Session Is Given" do
    session = Session.new

    test "Is an error" do
      assert_raises(Output::Get::Error) do
        Output::Get.(session, styling: true)
      end
    end
  end
end
