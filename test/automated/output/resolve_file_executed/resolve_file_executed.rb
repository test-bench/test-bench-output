require_relative '../../automated_init'

context "Output" do
  context "Resolve File Executed" do
    file_executed = Controls::Events::FileExecuted.example

    output = Output.new

    output.resolve(
      file_executed,
      Controls::Status.example
    )

    context "Newline is printed" do
      control_text = "\n"

      comment "Printed Text: #{output.writer.written_text.inspect}"
      detail "Control Text: #{control_text.inspect}"

      test do
        assert(output.writer.written?(control_text))
      end
    end
  end
end
