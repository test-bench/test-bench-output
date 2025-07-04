require_relative '../automated_init'

context "Comment Style" do
  context "Get" do
    [
      ["Detect", 'detect', :detect],
      ["Normal", 'normal', :normal],
      ["Heading", 'heading', :heading],
      ["Block", 'block', :block],
      ["Line Number", 'line_number', :line_number],
      ["Raw", 'raw', :raw]
    ].each do |context_title, comment_disposition, control_style|
      context "#{context_title}" do
        comment_style = CommentStyle.get(comment_disposition)

        comment comment_style.inspect
        detail "Control: #{control_style.inspect}"

        test do
          assert(comment_style == control_style)
        end
      end
    end

    context "Disposition Doesn't Correspond With Any Style" do
      comment_disposition = Controls::CommentStyle::Disposition.example

      comment_style = CommentStyle.get(comment_disposition)

      comment comment_style.inspect

      test do
        assert(comment_style.nil?)
      end
    end
  end
end
