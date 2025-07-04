require_relative '../../../automated_init'

context "Branch" do
  context "Pend Event" do
    context "Event Appended" do
      branch = Branch.new

      event = Controls::Event.example

      branch.pend(event)

      entries = branch.entries
      detail "Entries: #{entries.inspect}"

      appended = entries.include?(event)

      test do
        assert(appended)
      end
    end
  end
end
