require_relative '../../../automated_init'

context "Output" do
  context "Merge" do
    context "Output Level" do
      context "Not Root" do
        output_level = Level.abort
        status = Controls::Status::Passed.example

        output = Output.new
        output.output_level = output_level

        output.branch(Controls::Event.other_example)

        branch = output.branch(Controls::Event.other_example)
        branch.status = status

        control_event = Controls::Event.example
        output.merge(control_event)

        context "Event is pended" do
          pended = false

          output.current_branch.each do |event|
            if event == control_event
              pended = true
              break
            end
          end

          test do
            assert(pended)
          end
        end

        context "Popped from branch stack" do
          popped = output.branches.count == 1

          test do
            assert(popped)
          end
        end
      end
    end
  end
end
