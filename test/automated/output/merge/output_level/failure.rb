require_relative '../../../automated_init'

context "Output" do
  context "Resolve File Queued" do
    context "Output Level" do
      context "Failure" do
        output_level = Level.failure

        [
          ["Aborted", Controls::Status::Aborted.example],
          ["Failed", Controls::Status::Failed.example]
        ].each do |context_title, status|

          context "#{context_title}" do
            output = Output.new
            output.output_level = output_level

            branch = output.branch(Controls::Event.example)
            branch.status = status

            output.merge(Controls::Events::Commented.example)

            context "Pended events are resolved" do
              detail "Printed Text: #{output.writer.written_text.inspect}"

              resolved = output.writer.written?

              test do
                assert(resolved)
              end
            end
          end
        end

        [
          ["No Status", Controls::Status::None.example],
          ["Incomplete", Controls::Status::Incomplete.example],
          ["Passed", Controls::Status::Passed.example]
        ].each do |context_title, status|

          context "#{context_title}" do
            output = Output.new
            output.output_level = output_level

            branch = output.branch(Controls::Event.example)
            branch.status = status

            output.merge(Controls::Events::Commented.example)

            context "Pended events aren't resolved" do
              detail "Printed Text: #{output.writer.written_text.inspect}"

              resolved = output.writer.written?

              test do
                refute(resolved)
              end
            end
          end
        end
      end
    end
  end
end
