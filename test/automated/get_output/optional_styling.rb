require_relative '../automated_init'

context "Get Output" do
  context "Optional Styling" do
    substitute_session = Session::Substitute.build

    text = Controls::Text.example
    commented = Controls::Events::Commented.example(text:, style: CommentStyle.heading)
    substitute_session.record_event(commented)

    other_text = Controls::Text.other_example
    detailed = Controls::Events::Detailed.example(text: other_text, style: CommentStyle.block)
    substitute_session.record_event(detailed)

    output_text = Output::Get.(substitute_session, styling: true)

    control_output_text = <<~TEXT
    \e[1m#{text}\e[m
    \e[7m \e[27m #{other_text}\e[m
    TEXT

    comment output_text.inspect
    detail "Control: #{control_output_text.inspect}"

    test do
      assert(output_text == control_output_text)
    end
  end
end
