require_relative '../../automated_init'

context "Output" do
  context "Resolve Detailed Event" do
    context "Incorrect Detail Policy" do
      detail_policy = :incorrect_detail_policy

      output = Output.new
      output.detail_policy = detail_policy

      detailed = Controls::Events::Detailed.example

      test "Is an error" do
        assert_raises(DetailPolicy::Error) do
          output.resolve(
            detailed,
            Controls::Status.example
          )
        end
      end
    end
  end
end
