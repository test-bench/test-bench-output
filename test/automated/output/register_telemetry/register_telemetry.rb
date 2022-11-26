require_relative '../../automated_init'

context "Output" do
  context "Register Telemetry" do
    telemetry = Telemetry.new

    device = Controls::Device.example
    styling = Controls::Styling.random
    detail = Controls::Detail.random

    output = Output.register(telemetry, device:, styling:, detail:)

    test! "Registered" do
      assert(telemetry.registered?(output))
    end

    context "Configured" do
      comment output.class.name

      configured = output.instance_of?(Output) &&
        output.writer.device == device &&
        output.writer.styling == styling &&
        output.detail == detail

      test do
        assert(configured)
      end
    end
  end
end
