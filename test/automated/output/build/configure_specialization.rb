require_relative '../../automated_init'

context "Output" do
  context "Build" do
    context "Configure Specialization" do
      output = Controls::Output::Configure::Example.build(some_attr: 'some-value')

      context "Configured" do
        configured = output.configured?('some-value')

        test do
          assert(configured)
        end
      end
    end
  end
end
