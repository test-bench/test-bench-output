require_relative '../../automated_init'

context "Output" do
  context "Resolve Commented Event" do
    text = Controls::Text.example
    commented = Controls::Events::Commented.example(text:)

    output = Output.new

    output.resolve(
      commented,
      Controls::Status.example
    )

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
