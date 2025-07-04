require_relative '../automated_init'

context "Output" do
  context "Branch" do
    output = Output.new

    event = Controls::Event.example
    branch = output.branch(event)

    context "Event is pended" do
      pended = branch.entries.last == event

      test do
        assert(pended)
      end
    end

    context "Pushed onto branch stack" do
      pushed = output.branches.last == branch

      test do
        assert(pushed)
      end
    end
  end
end
