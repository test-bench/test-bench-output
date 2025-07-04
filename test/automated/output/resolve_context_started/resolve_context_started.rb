require_relative '../../automated_init'

context "Output" do
  context "Resolve Context Started" do
    title = Controls::Events::ContextStarted.title
    context_started = Controls::Events::ContextStarted.example(title:)

    output = Output.new

    output.resolve(
      context_started,
      Controls::Status::None.example
    )

    context "Printed" do
      control_text = "#{title}\n"

      comment output.writer.written_text.inspect
      detail "Control Text: #{control_text.inspect}"

      test do
        assert(output.writer.written?(control_text))
      end
    end

    context "Writer" do
      indented = output.writer.indentation_depth > 0

      test "Indented" do
        assert(indented)
      end
    end
  end
end
