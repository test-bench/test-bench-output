require_relative '../../automated_init'

context "Writer" do
  context "Written Predicate" do
    context "Optional Data Omitted" do
      data = Controls::Data.example

      context "Written" do
        compare_data = data

        writer = Output::Writer.new
        writer.write(data)

        written = writer.written?

        test do
          assert(written)
        end
      end

      context "Not Written" do
        writer = Output::Writer.new

        written = writer.written?

        test do
          refute(written)
        end
      end
    end
  end
end
