require_relative '../automated_init'

context "Output" do
  context "Register Telemetry" do
    telemetry = Telemetry.new

    device = Controls::Device.example
    styling = Controls::Styling.random

    output = Controls::Output::Example.register(telemetry, device:, styling:)

    test! "Registered" do
      assert(telemetry.registered?(output))
    end

    context "Writer Dependency" do
      writer = output.writer

      context "Configured" do
        comment writer.class.name

        configured = writer.instance_of?(Output::Writer) &&
          writer.device == device &&
          writer.styling == styling

        test do
          assert(configured)
        end
      end
    end
  end
end
