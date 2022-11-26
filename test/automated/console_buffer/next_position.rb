require_relative '../automated_init'

context "Buffer" do
  context "Console Buffer" do
    context "Next Position" do
      width, height = 3, 3

      [
        [
          "No Newline", [
            ["Text Fits Within Row", 0, 0, '··', 0, 2, 0],
            ["Text Extends To End Of Row", 0, 0, '···', 1, 0, 0],
            ["Text Extends To Next Row", 0, 1, '···', 1, 1, 0],
            ["Text Extends To End of Next Row", 0, 0, '·····', 1, 2, 0],
            ["Text Extends Across Multiple Rows", 0, 1, '······', 2, 1, 0],
            ["Text Scrolls", 1, 2, '····', 2, 0, 1],
            ["Text Scrolls Multiple Rows", 1, 2, '········', 2, 1, 2]
          ],
        ],[
          "Newline", [
            ["Text Fits Within Row", 0, 0, "··\n", 1, 0, 0],
            ["Text Extends To End Of Row", 0, 0, "···\n", 1, 0, 0],
            ["Text Extends From Middle To End Of Row", 0, 1, "··\n", 1, 0, 0],
            ["Text Extends To Next Row", 0, 1, "···\n", 2, 0, 0],
            ["Text Extends To End of Next Row", 0, 0, "·····\n", 2, 0, 0],
            ["Text Extends Across Multiple Rows", 0, 1, "······\n", 2, 0, 1],
            ["Text Scrolls Multiple Rows", 1, 2, "·······\n", 2, 0, 2],
            ["Just Newline", 0, 0, "\n", 1, 0, 0],
            ["Just Newline, Middle of Line", 0, 1, "\n", 1, 0, 0],
            ["Just Newline, End of Line", 0, 2, "\n", 1, 0, 0]
          ]
        ]
      ].each do |outer_title, control_values|
        control_values.each do |title, row, column, text, control_row, control_column, control_scroll_rows|
          context "#{title}" do
            console_buffer = Output::Writer::Buffer::Console.new
            console_buffer.set_geometry(width, height, row, column)

            next_row, next_column, scroll_rows = console_buffer.next_position(text)

            comment "Text: #{text.inspect}"
            comment "Position: #{row},#{column} => #{next_row},#{next_column} (#{scroll_rows} rows scrolled)"
            detail "Control Position: #{control_row},#{control_column} (#{control_scroll_rows} rows scrolled)"

            test "Next row" do
              assert(next_row == control_row)
            end

            test "Next column" do
              assert(next_column == control_column)
            end

            test "Scroll Rows" do
              assert(scroll_rows == control_scroll_rows)
            end
          end
        end
      end
    end
  end
end
