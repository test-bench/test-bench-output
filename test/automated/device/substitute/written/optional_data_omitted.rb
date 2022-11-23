require_relative '../../../automated_init'

context "Substitute Device" do
  context "Written Predicate" do
    context "Optional Data Omitted" do
      context "Written" do
        device = Output::Device::Substitute.build

        data = Controls::Data.example
        device.write(data)

        written = device.written?

        test do
          assert(written)
        end
      end

      context "Not Written" do
        device = Output::Device::Substitute.build

        written = device.written?

        test do
          refute(written)
        end
      end
    end
  end
end
