require_relative '../../automated_init'

context "Writer" do
  context "Write" do
    context "Synchronous Mode" do
      writer = Output::Writer.new
      writer.sync = true

      context "Write Data" do
        data = Controls::Data.example

        writer.write(data)

        detail "Written Data: #{data.inspect}"

        context "Writer's Buffer" do
          buffer = writer.buffer

          contents = buffer.contents

          comment "Buffered Data: #{contents.inspect}"

          not_buffered = contents.empty?

          test "Not buffered" do
            assert(not_buffered)
          end
        end

        context "Device" do
          device = writer.device

          comment "Written Data: #{device.written_data.inspect}"

          test "Received the written data" do
            assert(device.written?(data))
          end
        end
      end
    end
  end
end
