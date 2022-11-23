require_relative '../../../automated_init'

context "Substitute Device" do
  context "Flushed Predicate" do
    device = Output::Device::Substitute.build

    control_data = Controls::Data.example
    device.write(control_data)

    device.flush

    context "Given Data Corresponds With Flushed Data" do
      data = control_data

      comment data.inspect
      detail "Control Data: #{control_data.inspect}"

      flushed = device.flushed?(data)

      context "Flushed" do
        assert(flushed)
      end
    end

    context "Given Data Doesn't Correspond With Flushed Data" do
      data = Controls::Data.random

      comment data.inspect
      detail "Control Data: #{control_data.inspect}"

      flushed = device.flushed?(data)

      context "Flushed" do
        refute(flushed)
      end
    end
  end
end
