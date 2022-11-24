require_relative '../../automated_init'

context "Writer" do
  context "Substitute" do
    substitute = Output::Writer::Substitute.build

    text = Controls::Text.example
    substitute.print(text)

    context "Written Text" do
      written_text = substitute.written_text

      comment written_text.inspect
      detail "Control: #{text.inspect}"

      test do
        assert(written_text == text)
      end
    end
  end
end
