require_relative '../../automated_init'

context "Output" do
  context "Resolve Detailed Event" do
    context "Details On Failure" do
      detail_policy = DetailPolicy.failure
      comment "Detail policy: #{detail_policy.inspect}"

      text = Controls::Text.example
      detailed = Controls::Events::Detailed.example(text:)

      [
        ["Failed", Controls::Status::Failed.example],
        ["Aborted", Controls::Status::Aborted.example]
      ].each do |context_title, status|
        context "#{context_title}" do
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
      end

      context "Didn't Fail" do
        [
          ["Passed", Controls::Status::Passed.example],
          ["No Result", Controls::Status::None.example],
          ["Incomplete", Controls::Status::Incomplete.example]
        ].each do |context_title, status|
          context "#{context_title}" do
            status = Controls::Status::Passed.example

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
  end
end
