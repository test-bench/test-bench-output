require_relative '../../automated_init'

context "Buffer" do
  context "Receive Data" do
    context "Limit" do
      data = Controls::Data.example

      context "Limit Exceeded" do
        limit = data.length - 1

        buffer = Output::Writer::Buffer.new
        buffer.limit = limit

        bytes_received = 0
        bytes_received += buffer.receive(data[0...1])
        bytes_received += buffer.receive(data[1..-1])

        test! do
          assert(bytes_received == limit)
        end

        context "Buffer's Contents" do
          contents = buffer.contents
          control_data = data[0...limit]

          comment contents.inspect
          detail "Control Data: #{control_data.inspect}"

          received = contents == control_data

          test "Received the data until limit was exceeded" do
            assert(received)
          end
        end
      end

      context "Limit Reached" do
        limit = data.bytesize

        buffer = Output::Writer::Buffer.new
        buffer.limit = limit

        bytes_received = 0
        bytes_received += buffer.receive(data[0...1])
        bytes_received += buffer.receive(data[1..-1])

        test! do
          assert(bytes_received == limit)
        end

        context "Buffer's Contents" do
          contents = buffer.contents
          control_data = data[0...limit]

          comment contents.inspect
          detail "Control Data: #{control_data.inspect}"

          received = contents == control_data

          test "Received all the data" do
            assert(received)
          end
        end
      end
    end
  end
end
