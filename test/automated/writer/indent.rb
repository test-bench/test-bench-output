require_relative '../automated_init'

context "Writer" do
  context "Indent" do
    writer = Output::Writer.new

    writer.increase_indentation

    writer.
      indent.
      indent

    context "Indentation is written" do
      control_text = '    '

      comment "Written Text: #{writer.device.written_text.inspect}"
      detail "Control Text: #{control_text.inspect}"

      test do
        assert(writer.device.written?(control_text))
      end
    end
  end
end
