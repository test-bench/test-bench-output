require_relative '../../automated_init'

context "Output" do
  context "Resolve Context Started" do
    context "Context Was Conclusive" do
      title = Controls::Events::ContextStarted.title

      [
        ["Passed", Controls::Status::Passed.example],
        ["Failed", Controls::Status::Failed.example],
        ["Incomplete", Controls::Status::Incomplete.example]
      ].each do |context_title, status|
        context "#{context_title}"  do
          context_started = Controls::Events::ContextStarted.example(title:)

          context "Styling Enabled" do
            output = Output.new

            output.writer.set_styling

            output.writer.increase_indentation
            comment "Writer indented"

            output.resolve(context_started, status)

            context "Printed" do
              control_text = "  \e[32m#{title}\e[m\n"

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

            output.resolve(context_started, status)

            context "Printed" do
              control_text = "  #{title}\n"

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
