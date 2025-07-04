require_relative '../../../automated_init'

context "Output" do
  context "Resolve File Queued" do
    context "Output Level" do
      context "Incorrect Level" do
        output_level = :incorrect_level

        output = Output.new
        output.output_level = output_level

        output.branch(Controls::Event.other_example)

        test "Is an error" do
          assert_raises(Level::Error) do
            output.merge(Controls::Event.example)
          end
        end
      end
    end
  end
end
