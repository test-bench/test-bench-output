require_relative '../../automated_init'

context "Writer" do
  context "Puts" do
    context "Column Sequence Reset" do
      writer = Output::Writer.new

      writer.column_sequence = 1

      text = Controls::Text.example

      context "Put Text" do
        writer.puts(text)

        column_sequence = writer.column_sequence

        comment column_sequence.inspect

        reset = column_sequence == 0

        test "Reset" do
          assert(reset)
        end
      end
    end
  end
end
