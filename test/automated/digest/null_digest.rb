require_relative '../automated_init'

context "Digest" do
  context "Null Digest" do
    digest = Output::Digest::Null.new

    data = Controls::Data.example

    context "Update" do
      test "Implemented" do
        refute_raises(NoMethodError) do
          digest.update(data)
        end
      end
    end

    context "Digest Predicate" do
      test "Negative" do
        refute(digest.digest?(data))
      end
    end
  end
end
