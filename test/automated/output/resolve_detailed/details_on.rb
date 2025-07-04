require_relative '../../automated_init'

context "Output" do
  context "Resolve Detailed Event" do
    context "Details On" do
      detail_policy = DetailPolicy.on
      comment "Detail policy: #{detail_policy.inspect}"

      text = Controls::Text.example
      detailed = Controls::Events::Detailed.example(text:)

      context "Failed" do
        status = Controls::Status::Failed.example

        output = Output.new
        output.detail_policy = detail_policy

        output.resolve(detailed, status)

        context "Printed" do
          control_text = "#{text}\n"

          comment output.writer.written_text.inspect
          detail "Control Text: #{control_text.inspect}"

          test do
            assert(output.writer.written?(control_text))
          end
        end
      end

      context "Didn't Fail" do
        status = Controls::Status::None.example

        output = Output.new
        output.detail_policy = detail_policy

        output.resolve(detailed, status)

        context "Printed" do
          control_text = "#{text}\n"

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
