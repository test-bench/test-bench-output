require_relative 'automated_init'

context "Register Telemetry Sink" do
  session = Session.new

  output = Output.register_telemetry_sink(session)

  context "Output" do
    context! "Configured" do
      configured = output.instance_of?(Output)

      test do
        assert(configured)
      end
    end

    context "Registered" do
      registered = session.telemetry.sinks.include?(output)

      test do
        assert(registered)
      end
    end
  end
end
