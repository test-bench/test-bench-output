require_relative '../../automated_init'

context "Writer" do
  context "Print" do
    context "Column Sequence Updated" do
      writer = Output::Writer.new

      text = Controls::Text.example

      context "Print Text" do
        text_length = text.length

        writer.print(text)

        column_sequence = writer.column_sequence

        comment column_sequence.inspect
        detail "Columns Written: #{text_length.inspect}"

        updated = column_sequence == text_length

        test "Updated" do
          assert(updated)
        end

        test "Increased by the number of characters written" do
          assert(column_sequence == text_length)
        end
      end
    end
  end
end
