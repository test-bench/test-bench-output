require_relative '../../automated_init'

context "Substitute Device" do
  context "Flush" do
    device = Output::Device::Substitute.build

    data = Controls::Data.example
    device.write(data)

    device.flush

    context "Flushed Data" do
      flushed_data = device.flushed_data

      comment flushed_data.inspect
      detail "Control: #{data.inspect}"

      test do
        assert(flushed_data == data)
      end
    end
  end
end
