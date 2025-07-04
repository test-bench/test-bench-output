require_relative '../automated_init'

context "Output" do
  context "Resolve Other Event" do
    event = Controls::Event.example

    output = Output.new

    test "Isn't an error" do
      refute_raises do
        output.resolve(
          event,
          Controls::Status.example
        )
      end
    end
  end
end
