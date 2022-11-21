require_relative '../../automated_init'

context "Buffer" do
  context "Flush Data" do
    buffer = Output::Writer::Buffer.new

    data = Controls::Data.example

    buffer.receive(data)

    buffer.flush

    context "Buffer's Contents" do
      contents = buffer.contents

      comment contents.inspect

      test "Empty" do
        assert(contents.empty?)
      end
    end
  end
end
