require_relative '../../../automated_init'

context "Output" do
  context "Pend Event" do
    context "Not Root" do
      context "Status Updated" do
        output = Output.new

        branch = Branch.new
        output.branches << branch

        status = Controls::Status::Passed.example
        output.status = status

        output.pend(Controls::Events::Failed.example)

        status_updated = status.result != Session::Result.passed

        test do
          assert(status_updated)
        end
      end
    end
  end
end
