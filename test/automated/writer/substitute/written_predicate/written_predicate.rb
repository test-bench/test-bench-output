require_relative '../../../automated_init'

context "Writer Substitute" do
  context "Written Predicate" do
    substitute = Output::Writer::Substitute.build

    control_text = Controls::Text.example

    substitute.write(control_text)

    comment "Written Text: #{control_text.inspect}"

    context "Affirmative" do
      text = control_text

      comment text.inspect
      detail "Written Text: #{substitute.written_text.inspect}"

      written = substitute.written?(text)

      test do
        assert(written)
      end
    end

    context "Negative" do
      text = Controls::Text.other_example

      comment text.inspect
      detail "Written Text: #{substitute.written_text.inspect}"

      written = substitute.written?(text)

      test do
        refute(written)
      end
    end
  end
end
