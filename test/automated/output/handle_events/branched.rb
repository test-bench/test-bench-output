require_relative '../../automated_init'

context "Output" do
  context "Handle Events" do
    context "Branched" do
      [
        ["Test Started", Controls::Events::TestStarted.example],
        ["Context Started", Controls::Events::ContextStarted.example],
        ["File Queued", Controls::Events::FileQueued.example]
      ].each do |context_title, event|

        context "#{context_title} Event" do
          output = Output.new

          assert(output.root?)

          output.handle(event)

          branched = !output.root?

          test! do
            assert(branched)
          end

          context "Event is pended" do
            pended = output.current_branch.entries.last == event

            test do
              assert(pended)
            end
          end
        end
      end
    end
  end
end
