require_relative '../../../automated_init'

context "Output" do
  context "Pend Event" do
    context "Not Root" do
      context "Pended" do
        output = Output.new

        branch = Branch.new
        output.branches << branch

        event = Controls::Event.example
        output.pend(event)

        pended = branch.entries.last == event

        test do
          assert(pended)
        end
      end
    end
  end
end
