module TestBench
  class Output
    class Writer
      class Buffer
        class Console
          def geometry
            @geometry ||= Geometry.new
          end
          attr_writer :geometry

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
