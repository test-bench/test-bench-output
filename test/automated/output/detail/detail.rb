require_relative '../../automated_init'

context "Output" do
  context "Detail" do
    detailed = Controls::Events::Detailed.example

    text = "#{detailed.text}\n"

    {
      Output::Mode.initial => text,
      Output::Mode.pending => '',
      Output::Mode.passing => '',
      Output::Mode.failing => text
    }.each do |mode, control_text|
      output = Controls::Output.example(mode:)

      context "Handle Detailed Event" do
        output.handle(detailed)

        context "Written Text" do
          writer = output.writer
          written_text = writer.written_text

          comment written_text
          detail "Control:", control_text

          test do
            assert(writer.written?(control_text))
          end
        end
      end
    end
  end
end
