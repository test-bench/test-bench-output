require_relative '../../automated_init'

context "Writer Substitute" do
  context "Written Text" do
    substitute = Output::Writer::Substitute.build

    text = Controls::Text.example
    substitute.print(text)

    written_text = substitute.written_text

    comment written_text.inspect
    detail "Control: #{text.inspect}"

    test do
      assert(written_text == text)
    end
  end
end
