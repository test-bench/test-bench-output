require_relative '../../automated_init'

context "Writer" do
  context "Sync" do
    context "Activated" do
      writer = Output::Writer.new
      writer.sync = false

      data = Controls::Data.example
      writer.buffer.receive(data)

      writer.sync = true

      sync = writer.sync

      test! do
        assert(sync)
      end

      context "Buffer's Contents" do
        contents = writer.buffer.contents

        comment contents.inspect

        flushed = contents.empty?

        test "Flushed" do
          assert(flushed)
        end
      end
    end
  end
end
