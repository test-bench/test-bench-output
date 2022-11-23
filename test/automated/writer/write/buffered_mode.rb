require_relative '../../automated_init'

context "Writer" do
  context "Write" do
    context "Buffered Mode" do
      writer = Output::Writer.new
      writer.sync = false

      context "Write Data" do
        data = Controls::Data.example

        writer.write(data)

        detail "Written Data: #{data.inspect}"

        context "Writer's Buffer" do
          buffer = writer.buffer

          contents = buffer.contents

          comment "Buffered Data: #{contents.inspect}"

          buffered = contents == data

          test "Buffered" do
            assert(buffered)
          end
        end

        context "Device" do
          device = writer.device

          comment "Written Data: #{device.written_data.inspect}"

          test "Didn't receive any data" do
            refute(device.written?)
          end
        end
      end
    end
  end
end
