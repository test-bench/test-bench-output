require_relative '../automated_init'

context "Substitute" do
  substitute = Output::Substitute.build

  event_1 = Controls::Event.event_data
  substitute.receive(event_1)

  event_2 = Controls::Event::Other.event_data
  substitute.receive(event_2)

  context "First Event" do
    received = substitute.received?(event_1)

    test "Received" do
      assert(received)
    end
  end

  context "Second Event" do
    received = substitute.received?(event_2)

    test "Received" do
      assert(received)
    end
  end
end
