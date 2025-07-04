require_relative '../../automated_init'

context "Branch" do
  context "Enumerate" do
    branch = Branch.new

    test_finished = Controls::Events::TestFinished.example
    failed = Controls::Events::Failed.example

    control_events = [
      test_finished,
      failed
    ]

    control_results = []

    passed_branch = Branch.new
    passed_branch.pend(test_finished)
    control_results << Session::Result.passed

    failed_branch = Branch.new
    failed_branch.pend(failed)
    control_results << Session::Result.failed

    branch.merge(passed_branch)
    branch.merge(failed_branch)

    events = []
    results = []

    branch.each do |event, status|
      result = status.result

      events << event
      results << result
    end

    context "Passing Branch" do
      context "Event" do
        yielded = events[0] == control_events[0]

        test "Yielded" do
          assert(yielded)
        end
      end

      context "Status" do
        yielded = results[0] == control_results[0]

        test "Yielded" do
          assert(yielded)
        end
      end
    end

    context "Failing Branch" do
      context "Event" do
        yielded = events[1] == control_events[1]

        test "Yielded" do
          assert(yielded)
        end
      end

      context "Status" do
        yielded = results[1] == control_results[1]

        test "Yielded" do
          assert(yielded)
        end
      end
    end
  end
end
