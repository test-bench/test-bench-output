require_relative '../../automated_init'

context "Substitute Device" do
  context "Write Data" do
    device = Output::Device::Substitute.build

    data = Controls::Data.example

    bytes_written = 0

    bytes_written += device.write(data[0...1])
    bytes_written += device.write(data[1..-1])

    context "Bytes Written" do
      control_bytes_written = data.bytesize

      comment bytes_written.inspect
      detail "Control: #{bytes_written.inspect}"

      test do
        assert(bytes_written == control_bytes_written)
      end
    end

    context "Written Data" do
      written_data = device.written_data

      comment written_data.inspect
      detail "Control: #{data.inspect}"

      test do
        assert(written_data == data)
      end
    end
  end
end
