require_relative '../../automated_init'

context "Writer" do
  context "Write" do
    context "Sequence Updated" do
      data = Controls::Data.example

      context "Not Buffering" do
        writer = Output::Writer.new

        context "Write Data" do
          bytes_written = 0

          bytes_written += writer.write(data[0...1])
          bytes_written += writer.write(data[0..-1])

          detail "Written Data: #{data.inspect}"

          context "Sequence" do
            sequence = writer.sequence

            comment sequence.inspect
            detail "Bytes Written: #{bytes_written.inspect}"

            test "Updated" do
              assert(sequence > 0)
            end

            test "Increased by the number of bytes written" do
              assert(sequence == bytes_written)
            end
          end
        end
      end

      context "Buffering" do
        context "Buffer's Limit Not Exceeded" do
          limit = data.bytesize

          writer = Output::Writer.new
          writer.sync = false

          writer.buffer.limit = limit

          context "Write Data" do
            bytes_written = 0

            bytes_written += writer.write(data[0...1])
            bytes_written += writer.write(data[0..-1])

            detail "Written Data: #{data.inspect}"

            context "Sequence" do
              sequence = writer.sequence

              comment sequence.inspect
              detail "Limit: #{limit.inspect}"

              test "Updated" do
                assert(sequence > 0)
              end

              test "Increased by the number of bytes received" do
                assert(sequence == limit)
              end
            end
          end
        end

        context "Buffer's Limit Exceeded" do
          limit = data.bytesize - 1

          writer = Output::Writer.new
          writer.sync = false

          writer.buffer.limit = limit

          context "Write Data" do
            bytes_written = 0

            bytes_written += writer.write(data[0...1])
            bytes_written += writer.write(data[0..-1])

            detail "Written Data: #{data.inspect}"

            context "Sequence" do
              sequence = writer.sequence

              comment sequence.inspect
              detail "Limit: #{limit.inspect}"

              test "Updated" do
                assert(sequence > 0)
              end

              test "Increased by the number of bytes received" do
                assert(sequence == limit)
              end
            end
          end
        end
      end
    end
  end
end
