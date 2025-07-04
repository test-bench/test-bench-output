require_relative '../../../automated_init'

context "Substitute Device" do
  context "Written Predicate" do
    context "Optional Text Omitted" do
      context "Affirmative" do
        substitute = Device::Substitute.build

        substitute.write(Controls::Text.example)

        written = substitute.written?

        test do
          assert(written)
        end
      end

      context "Negative" do
        substitute = Device::Substitute.build

        written = substitute.written?

        test do
          refute(written)
        end
      end
    end
  end
end
