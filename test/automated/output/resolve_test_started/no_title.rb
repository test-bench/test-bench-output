require_relative '../../automated_init'

context "Output" do
  context "Resolve Test Started" do
    context "No Title" do
      test_started = Controls::Events::TestStarted::NoTitle.example

      output = Output.new

      output.resolve(
        test_started,
        Controls::Status.example
      )

      context "Not printed" do
        detail "Printed Text: #{output.writer.written_text.inspect}"

        test do
          refute(output.writer.written?)
        end
      end

      context "Writer" do
        indented = output.writer.indentation_depth > 0

        test "Not indented" do
          refute(indented)
        end
      end
    end
  end
end
