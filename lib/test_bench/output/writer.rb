module TestBench
  class Output
    class Writer
      def device
        @device ||= Device::Substitute.build
      end
      attr_writer :device

      def alternate_device
        @alternate_device ||= Device::Substitute.build
      end
      attr_writer :alternate_device

      def digest
        @digest ||= Digest.new
      end
      attr_writer :digest

      def sequence
        @sequence ||= 0
      end
      attr_writer :sequence

      def column_sequence
        @column_sequence ||= 0
      end
      attr_writer :column_sequence

      def buffer
        @buffer ||= Buffer.new
      end
      attr_writer :buffer

      def sync
        @sync.nil? ? @sync = true : @sync
      end

      def print(text)
        text = text.dump[1...-1]

        self.column_sequence += text.length

        write(text)

        self
      end

      def write(data)
        if sync
          device.write(data)
          alternate_device.write(data)

          bytes_written = data.bytesize
        else
          bytes_written = buffer.receive(data)
        end

        self.sequence += bytes_written

        data = data[0...bytes_written]
        digest.update(data)

        bytes_written
      end

      def tty?
        device.tty?
      end

      def flush
        buffer.flush(device, alternate_device)
      end

      def sync=(sync)
        @sync = sync

        if sync
          flush
        end
      end

      def written?(data=nil)
        if data.nil?
          sequence > 0
        else
          digest.digest?(data)
        end
      end

      def current?(sequence)
        sequence >= self.sequence
      end
    end
  end
end
