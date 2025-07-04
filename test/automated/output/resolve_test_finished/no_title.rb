require_relative '../../automated_init'

context "Output" do
  context "Resolve Test Finished" do
    context "No Title" do
      test_finished = Controls::Events::TestFinished::NoTitle.example

      output = Output.new

      control_indentation_depth = 11
      output.writer.indentation_depth = control_indentation_depth

      output.resolve(
        test_finished,
        Controls::Status.example
      )

      context "Writer" do
        deindented = output.writer.indentation_depth < control_indentation_depth

        test "Not deindented" do
          refute(deindented)
        end
      end
    end
  end
end
