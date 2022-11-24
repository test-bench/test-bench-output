require_relative '../../automated_init'

context "Writer" do
  context "Print" do
    context "Indentation" do
      indentation_depth = 2
      detail "Indentation Depth: #{indentation_depth.inspect}"

      text = Controls::Text.example

      context "Column Sequence is Zero" do
        writer = Output::Writer.new

        indentation_depth.times do
          writer.indent!
        end

        context "Put Text" do
          control_text = "    #{text}\n"

          writer.puts(text)

          written_text = writer.device.written_data

          comment written_text.inspect
          detail "Control Text: #{control_text.inspect}"

          test "Indented" do
            assert(writer.device.written?(control_text))
          end
        end
      end

      context "Column Sequence isn't Zero" do
        writer = Output::Writer.new
        writer.column_sequence = 1

        indentation_depth.times do
          writer.indent!
        end

        context "Put Text" do
          control_text = "#{text}\n"

          writer.puts(text)

          written_text = writer.device.written_data

          comment written_text.inspect
          detail "Control Text: #{control_text.inspect}"

          test "Not Indented" do
            assert(writer.device.written?(control_text))
          end
        end
      end
    end
  end
end
