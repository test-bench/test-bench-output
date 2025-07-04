require_relative '../automated_init'

context "Writer" do
  context "Increase and Decrease Indentation Depth" do
    writer = Output::Writer.new

    11.times do
      writer.increase_indentation
    end

    10.times do
      writer.decrease_indentation
    end

    context "Indentation Depth" do
      indentation_depth = writer.indentation_depth
      control_indentation_depth = 1

      comment indentation_depth.inspect
      detail "Control: #{control_indentation_depth.inspect}"

      test do
        assert(indentation_depth == control_indentation_depth)
      end
    end
  end
end
