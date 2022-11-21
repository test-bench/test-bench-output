module TestBench
  class Output
    class Writer
      class Buffer
        attr_accessor :limit

        def contents
          @contents ||= String.new
        end
        attr_writer :contents

        def receive(data)
          bytes = data.bytesize

          if not limit.nil?
            final_size = contents.bytesize + data.bytesize

            if final_size > limit
              bytes = limit - contents.bytesize
            end
          end

          data = data[0...bytes]

          contents << data

          bytes
        end

        def limit?
          !limit.nil?
        end
      end
    end
  end
end
