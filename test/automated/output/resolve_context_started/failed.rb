require_relative '../../automated_init'

context "Output" do
  context "Resolve Context Started" do
    context "Failed Result" do
      status = Controls::Status::Failed.example

      title = Controls::Events::ContextStarted.title
      context_started = Controls::Events::ContextStarted.example(title:)

      context "Styling Enabled" do
        output = Output.new

        output.writer.set_styling

        output.writer.increase_indentation
        comment "Writer indented"

        output.resolve(context_started, status)

        context "Printed" do
          control_text = "  \e[31m#{title}\e[m\n"

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
