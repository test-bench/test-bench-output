require_relative '../../automated_init'

context "Output" do
  context "Handle Events" do
    context "Merged" do
      [
        ["Test Finished", Controls::Events::TestFinished.example],
        ["Context Finished", Controls::Events::ContextFinished.example],
        ["File Executed", Controls::Events::FileExecuted.example]
      ].each do |context_title, control_event|

        context "#{context_title} Event" do
          output = Output.new

          output.branch(Controls::Event.example)

          output.handle(control_event)

          merged = output.root?

          test do
            assert(merged)
          end
        end
      end
    end
  end
end
