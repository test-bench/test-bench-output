require_relative '../../automated_init'

context "Output" do
  context "Resolve Detailed Event" do
    context "Details Off" do
      detail_policy = DetailPolicy.off
      comment "Detail policy: #{detail_policy.inspect}"

      text = Controls::Text.example
      detailed = Controls::Events::Detailed.example(text:)

      context "Failed" do
        status = Controls::Status::Failed.example

        output = Output.new
        output.detail_policy = detail_policy

        output.resolve(detailed, status)

        context "Didn't print" do
          detail "Printed Text: #{output.writer.written_text.inspect}"

          test do
            refute(output.writer.written?)
          end
        end
      end

      context "Didn't Fail" do
        status = Controls::Status::None.example

        output = Output.new
        output.detail_policy = detail_policy

        output.resolve(detailed, status)

        context "Didn't print" do
          detail "Printed Text: #{output.writer.written_text.inspect}"

          test do
            refute(output.writer.written?)
          end
        end
      end
    end
  end
end
