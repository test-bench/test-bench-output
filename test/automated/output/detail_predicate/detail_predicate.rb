require_relative '../../automated_init'

context "Output" do
  context "Detail Predicate" do
    [
      ["On", Output::Detail.on, true, true, true, true],
      ["Off", Output::Detail.off, false, false, false, false],
      ["Detect", Output::Detail.failure, true, false, false, true]
    ].each do |title, policy, initial_value, pending_value, passing_value, failing_value|
      context "Policy: #{title}" do
        output = Output.new

        output.detail_policy = policy

        context "Initial Mode" do
          output.mode = Output::Mode.initial

          details = output.detail?

          comment details.inspect
          detail "Control: #{initial_value}"

          test do
            assert(details == initial_value)
          end
        end

        context "Pending Mode" do
          output.mode = Output::Mode.pending

          details = output.detail?

          comment details.inspect
          detail "Control: #{pending_value}"

          test do
            assert(details == pending_value)
          end
        end

        context "Passing Mode" do
          output.mode = Output::Mode.passing

          details = output.detail?

          comment details.inspect
          detail "Control: #{passing_value}"

          test do
            assert(details == passing_value)
          end
        end

        context "Failing Mode" do
          output.mode = Output::Mode.failing

          details = output.detail?

          comment details.inspect
          detail "Control: #{failing_value}"

          test do
            assert(details == failing_value)
          end
        end
      end
    end
  end
end
