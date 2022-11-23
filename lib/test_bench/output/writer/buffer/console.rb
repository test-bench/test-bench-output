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
          end
        end
      end
    end
  end
end
