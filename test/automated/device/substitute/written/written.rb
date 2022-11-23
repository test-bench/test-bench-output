require_relative '../../../automated_init'

context "Substitute Device" do
  context "Written Predicate" do
    device = Output::Device::Substitute.build

    control_data = Controls::Data.example

    device.write(control_data)

    context "Given Data Corresponds With Written Data" do
      data = control_data

      comment data.inspect
      detail "Control Data: #{control_data.inspect}"

      written = device.written?(data)

      context "Written" do
        assert(written)
      end
    end

    context "Given Data Doesn't Correspond With Written Data" do
      data = Controls::Data.random

      comment data.inspect
      detail "Control Data: #{control_data.inspect}"

      written = device.written?(data)

      context "Written" do
        refute(written)
      end
    end
  end
end
