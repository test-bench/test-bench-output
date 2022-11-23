require_relative '../automated_init'

context "Writer" do
  context "Current Predicate" do
    writer = Output::Writer.new

    control_sequence = 11
    detail "Sequence: #{control_sequence.inspect}"

    writer.sequence = control_sequence

    context "Current" do
      context "Given Sequence Exceeds Buffer's Sequence" do
        sequence = control_sequence + 1

        current = writer.current?(sequence)

        comment current.inspect

        test do
          assert(current)
        end
      end

      context "Given Sequence Equals Buffer's Sequence" do
        sequence = control_sequence

        current = writer.current?(sequence)

        comment current.inspect

        test do
          assert(current)
        end
      end
    end

    context "Not Current" do
      context "Given Sequence Precedes Buffer's Sequence" do
        sequence = control_sequence - 1

        current = writer.current?(sequence)

        comment current.inspect

        test do
          refute(current)
        end
      end
    end
  end
end
