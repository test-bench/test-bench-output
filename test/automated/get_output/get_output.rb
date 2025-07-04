require_relative '../automated_init'

context "Get Output" do
  substitute_session = Session::Substitute.build

  text = Controls::Text.example
  commented = Controls::Events::Commented.example(text:)
  substitute_session.record_event(commented)

  other_text = Controls::Text.other_example
  detailed = Controls::Events::Detailed.example(text: other_text)
  substitute_session.record_event(detailed)

  output_text = Output::Get.(substitute_session)

  control_output_text = "#{text}\n#{other_text}\n"

  comment output_text.inspect
  detail "Control: #{control_output_text.inspect}"

  test do
    assert(output_text == control_output_text)
  end
end
