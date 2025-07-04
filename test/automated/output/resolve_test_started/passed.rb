require_relative '../../automated_init'

context "Output" do
  context "Resolve Test Started" do
    context "Test Passed" do
      status = Controls::Status::Passed.example

      title = Controls::Events::TestStarted.title
      test_started = Controls::Events::TestStarted.example(title:)

      context "Styling Enabled" do
        output = Output.new

        output.writer.set_styling

        output.writer.increase_indentation
        comment "Writer indented"

        output.resolve(test_started, status)

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

        output.resolve(test_started, status)

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
