require_relative '../../automated_init'

context "Output" do
  context "Resolve Test Started" do
    title = Controls::Events::TestStarted.title
    test_started = Controls::Events::TestStarted.example(title:)

    output = Output.new

    output.resolve(
      test_started,
      Controls::Status::Passed.example
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
