require_relative '../../automated_init'

context "Output" do
  context "Resolve Detailed Event" do
    detail_policy = DetailPolicy.on
    comment "Detail policy: #{detail_policy.inspect}"

    style = CommentStyle.block
    comment "Style style: #{style.inspect}"

    text = Controls::Text.example
    detailed = Controls::Events::Detailed.example(text:, style:)

    output = Output.new
    output.detail_policy = detail_policy

    output.resolve(
      detailed,
      Controls::Status.example
    )

    context "Printed" do
      control_text = "> #{text}\n"

      comment output.writer.written_text.inspect
      detail "Control Text: #{control_text.inspect}"

      test do
        assert(output.writer.written?(control_text))
      end
    end
  end
end
