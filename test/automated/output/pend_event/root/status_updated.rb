require_relative '../../../automated_init'

context "Output" do
  context "Pend Event" do
    context "Root" do
      context "Status Is Updated" do
        output = Output.new

        status = Controls::Status::Passed.example
        output.status = status

        output.pend(Controls::Events::Failed.example)

        output.pend(Controls::Events::Failed.example)

        status_updated = status.result != Session::Result.passed

        test do
          assert(status_updated)
        end
      end
    end
  end
end
