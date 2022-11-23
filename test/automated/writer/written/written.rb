require_relative '../../automated_init'

context "Writer" do
  context "Written Predicate" do
    control_data = Controls::Data.example

    context "Written" do
      data = control_data

      context "Given Data Was Written" do
        writer = Output::Writer.new
        writer.write(control_data)

        written = writer.written?(data)

        test do
          assert(written)
        end
      end
    end

    context "Not Written" do
      data = Controls::Data.random

      context "Given Data Wasn't Written" do
        writer = Output::Writer.new
        writer.write(control_data)

        written = writer.written?(data)

        test do
          refute(written)
        end
      end

      context "No Data Was Written" do
        writer = Output::Writer.new

        written = writer.written?(data)

        test do
          refute(written)
        end
      end
    end
  end
end
