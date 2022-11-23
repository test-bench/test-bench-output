module TestBench
  class Output
    class Writer
      class Buffer
        class Console
          def device
            @device ||= Device::Null.build
          end
          attr_writer :device

          def geometry
            @geometry ||= Geometry.get
          end
          attr_writer :geometry

          def self.build(device=nil)
            device ||= Defaults.device

            instance = new

            if device.tty?
              instance.device = device
            end

            instance
          end

          def self.configure(receiver, device: nil, attr_name: nil)
            attr_name ||= :buffer

            instance = build(device)
            receiver.public_send(:"#{attr_name}=", instance)
          end

          def set_geometry(width, height, row, column)
            geometry = Geometry.new(width, height, row, column)
            self.geometry = geometry
          end

          def capacity
            geometry.capacity
          end

          def next_position(text)
            geometry.next_position(text)
          end

          Geometry = Struct.new(:width, :height, :row, :column) do
            def self.get
              instance = new

              STDIN.raw do |stdin|
                instance.height, instance.width = stdin.winsize

                instance.row, instance.column = stdin.cursor
              end

              instance
            end

            def capacity
              capacity = 0

              rows_remaining = height - row - 1

              if rows_remaining > 0
                capacity += (rows_remaining - 1) * width

                final_row = width - column
                capacity += final_row
              end

              capacity
            end

            def next_position(text)
              text_length = text.length

              newline = text.end_with?("\n")
              if newline
                text_length -= 1
              end

              row = self.row
              column = self.column

              text_rows, text_columns = text_length.divmod(width)

              row += text_rows

              columns_remaining = width - column
              if columns_remaining > text_columns
                column += text_columns
              else
                row += 1
                column = text_columns - columns_remaining
              end

              if newline
                reached_next_line = column == 0 && row > self.row

                newline_needed = !reached_next_line
                if newline_needed
                  row += 1
                  column = 0
                end
              end

              if row >= height
                row_limit = height - 1

                scroll_rows = row - row_limit
                row = row_limit
              else
                scroll_rows = 0
              end

              return row, column, scroll_rows
            end
          end
        end
      end
    end
  end
end
