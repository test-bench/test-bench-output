require_relative '../../../automated_init'

context "Substitute Device" do
  context "Flushed Predicate" do
    context "Optional Data Omitted" do
      data = Controls::Data.example

      context "Flushed" do
        device = Output::Device::Substitute.build
        device.write(data)

        device.flush

        flushed = device.flushed?

        test do
          assert(flushed)
        end
      end

      context "Not Flushed" do
        device = Output::Device::Substitute.build
        device.write(data)

        flushed = device.flushed?

        test do
          refute(flushed)
        end
      end
    end
  end
end
