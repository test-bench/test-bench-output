require_relative '../../automated_init'

context "Buffer" do
  context "Flush Data" do
    context "Optional Devices Given" do
      device_1 = Controls::Device.example
      device_2 = Controls::Device.example

      buffer = Output::Writer::Buffer.new

      data = Controls::Data.example
      buffer.receive(data)

      buffer.flush(device_1, device_2)

      context "First Device" do
        received_data = device_1.written_data

        comment "Received Data: #{received_data.inspect}"
        detail "Buffered Data: #{data.inspect}"

        test "Received the flushed data" do
          assert(received_data == data)
        end
      end

      context "Second Device" do
        received_data = device_1.written_data

        comment "Received Data: #{received_data.inspect}"
        detail "Buffered Data: #{data.inspect}"

        test "Received the flushed data" do
          assert(received_data == data)
        end
      end
    end
  end
end
