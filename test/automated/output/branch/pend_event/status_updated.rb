require_relative '../../../automated_init'

context "Branch" do
  context "Pend Event" do
    context "Status Updated" do
      branch = Branch.new

      status = branch.status

      initial_result = branch.status
      comment "Initial result: #{initial_result.inspect}"

      assert(initial_result != Session::Result.aborted)

      branch.pend(Controls::Events::Aborted.example)

      context "Status" do
        result = status.result
        comment "Result: #{result.inspect}"

        updated = result == Session::Result.aborted

        test "Updated" do
          assert(updated)
        end
      end
    end
  end
end
