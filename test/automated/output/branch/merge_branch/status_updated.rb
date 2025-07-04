require_relative '../../../automated_init'

context "Branch" do
  context "Merge Branch" do
    context "Status Updated" do
      branch = Branch.new
      4.times do
        branch.pend(Controls::Events::TestFinished.example)
      end
      3.times do
        branch.pend(Controls::Events::Failed.example)
      end

      other_branch = Branch.new
      2.times do
        other_branch.pend(Controls::Events::Aborted.example)
      end
      other_branch.merge(branch)

      root_branch = Branch.new
      1.times do
        root_branch.pend(Controls::Events::Skipped.example)
      end
      root_branch.merge(other_branch)

      context "Status" do
        status = root_branch.status

        comment "Status: #{status.inspect}"

        updated =
          status.test_sequence == 4 &&
          status.failure_sequence == 3 &&
          status.error_sequence == 2 &&
          status.skip_sequence == 1

        test "Updated" do
          assert(updated)
        end
      end
    end
  end
end
