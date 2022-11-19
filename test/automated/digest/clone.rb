require_relative '../automated_init'

context "Digest" do
  context "Clone" do
    digest = Output::Digest.new

    data = Controls::Data.example
    digest.update(data)

    cloned_digest = digest.clone

    test! "Identical digest" do
      assert(cloned_digest.digest?(data))
    end

    context "Update Cloned Digest" do
      other_data = Controls::Data.random
      cloned_digest.update(other_data)

      context "Original Digest" do
        not_updated = digest.digest?(data)

        test "Not updated" do
          assert(not_updated)
        end
      end
    end
  end
end
