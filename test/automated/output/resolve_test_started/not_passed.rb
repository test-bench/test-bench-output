require_relative '../../automated_init'

context "Output" do
  context "Resolve Test Started" do
    context "Test Not Passed" do
      title = Controls::Events::TestStarted.title

      [
        ["Failed", Controls::Status::Failed.example, "#{title} (failed)"],
        ["Aborted", Controls::Status::Aborted.example, "#{title} (aborted)"],
        ["Incomplete", Controls::Status::Incomplete.example, "#{title} (inconclusive)"],
        ["No Result", Controls::Status::None.example, "#{title} (inconclusive)"]
      ].each do |context_title, status, control_title|
        context "#{context_title}"  do
          test_started = Controls::Events::TestStarted.example(title:)

          context "Styling Enabled" do
            output = Output.new

            output.writer.set_styling

            output.writer.increase_indentation
            comment "Writer indented"

            output.resolve(test_started, status)

            context "Printed" do
              control_text = "  \e[1;31m#{title}\e[m\n"

              comment output.writer.written_text.inspect
              detail "Control Text: #{control_text.inspect}"

              test do
                assert(output.writer.written?(control_text))
              end
            end
          end

          context "Styling Disabled" do
            output = Output.new

            output.writer.increase_indentation
            comment "Writer indented"

            output.resolve(test_started, status)

            context "Printed" do
              control_text = "  #{control_title}\n"

              comment output.writer.written_text.inspect
              detail "Control Text: #{control_text.inspect}"

              test do
                assert(output.writer.written?(control_text))
              end
            end
          end
        end
      end
    end
  end
end
