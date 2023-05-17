require_relative '../automated_init'

context "Substitute" do
  context "Handle" do
    event_data = Controls::Event.event_data

    context "Event" do
      substitute = Output::Substitute.build

      event = Controls::Event.example
      substitute.handle(event)

      context "Event Data" do
        received = substitute.received?(event_data)

        test "Received" do
          assert(received)
        end
      end
    end

    context "Event Data" do
      substitute = Output::Substitute.build

      substitute.handle(event_data)

      context "Received" do
        received = substitute.received?(event_data)

        test do
          assert(received)
        end
      end
    end
  end
end
