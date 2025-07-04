require_relative '../../automated_init'

context "Output" do
  context "Resolve File Queued" do
    context "Aborted" do
      file = Controls::Events::FileQueued.file
      file_queued = Controls::Events::FileQueued.example(file:)

      context "Styling Enabled" do
        output = Output.new

        output.writer.set_styling

        output.writer.increase_indentation
        comment "Writer indented"

        output.resolve(
          file_queued,
          Controls::Status.example
        )

        context "Printed" do
          control_text = "  \e[1;31mRunning #{file}\e[m\n"

          comment "Printed Text: #{output.writer.written_text.inspect}"
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

        output.resolve(
          file_queued,
          Controls::Status.example
        )

        context "Printed" do
          control_text = "  Running #{file} (aborted)\n"

          comment "Printed Text: #{output.writer.written_text.inspect}"
          detail "Control Text: #{control_text.inspect}"

          test do
            assert(output.writer.written?(control_text))
          end
        end
      end
    end
  end
end
