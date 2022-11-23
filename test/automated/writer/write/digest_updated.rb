require_relative '../../automated_init'

context "Writer" do
  context "Write" do
    context "Digest Updated" do
      data = Controls::Data.example

      context "Not Buffering" do
        writer = Output::Writer.new

        context "Write Data" do
          writer.write(data)

          detail "Written Data: #{data.inspect}"

          context "Digest" do
            digest = writer.digest

            comment digest.inspect

            updated = digest.digest?(data)

            test "Updated" do
              assert(updated)
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
            writer.write(data)

            detail "Written Data: #{data.inspect}"

            context "Digest" do
              digest = writer.digest

              comment digest.inspect

              updated = digest.digest?(data)

              test "Updated" do
                assert(updated)
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
            writer.write(data)

            detail "Written Data: #{data.inspect}"

            context "Digest" do
              digest = writer.digest

              comment digest.inspect

              updated = digest.digest?(data[0...limit])

              test "Updated" do
                assert(updated)
              end
            end
          end
        end
      end
    end
  end
end
