require_relative '../../automated_init'

context "Writer" do
  context "Styling Predicate" do
    context "Default Policy" do
      original_env = ENV.to_h

      ENV.clear

      context "TEST_BENCH_OUTPUT_STYLING isn't set" do
        control_policy = Output::Writer::Styling.default!

        writer = Output::Writer.new

        context "Styling Policy" do
          styling_policy = writer.styling_policy

          comment styling_policy.inspect
          detail "Control: #{control_policy.inspect}"

          test do
            assert(styling_policy == control_policy)
          end
        end
      end

      context "TEST_BENCH_OUTPUT_STYLING is set" do
        control_policy = Controls::Styling.random

        ENV['TEST_BENCH_OUTPUT_STYLING'] = control_policy.to_s

        writer = Output::Writer.new

        context "Styling Policy" do
          styling_policy = writer.styling_policy

          comment styling_policy.inspect
          detail "Control: #{control_policy.inspect}"

          test do
            assert(styling_policy == control_policy)
          end
        end
      end

    ensure
      ENV.replace(original_env)
    end
  end
end
