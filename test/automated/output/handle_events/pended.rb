require_relative '../../automated_init'

context "Output" do
  context "Handle Events" do
    context "Pended" do
      [
        ["Failed", Controls::Events::Failed.example],
        ["Aborted", Controls::Events::Aborted.example],
        ["Skipped", Controls::Events::Skipped.example],
        ["Commented", Controls::Events::Commented.example],
        ["Detailed", Controls::Events::Detailed.example],
        ["File Not Found", Controls::Events::FileNotFound.example]
      ].each do |context_title, event|

        context "#{context_title} Event" do
          output = Output.new

          branch = output.branch(Controls::Event.example)

          output.handle(event)

          pended = branch.entries.last == event

          test do
            assert(pended)
          end
        end
      end
    end
  end
end
