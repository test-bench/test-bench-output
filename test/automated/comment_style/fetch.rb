require_relative '../automated_init'

context "Comment Style" do
  context "Fetch" do
    context "Disposition Corresponds With A Style" do
      comment_disposition = Controls::CommentStyle.disposition

      comment_style = CommentStyle.fetch(comment_disposition)

      control_comment_style = Controls::CommentStyle.example

      comment comment_style.inspect
      detail "Control: #{control_comment_style.inspect}"

      test do
        assert(comment_style == control_comment_style)
      end
    end

    context "Disposition Doesn't Correspond With Any Style" do
      comment_disposition = Controls::CommentStyle::Disposition.example

      comment_style = CommentStyle.fetch(comment_disposition)

      control_comment_style = CommentStyle.normal

      comment comment_style.inspect
      detail "Control: #{control_comment_style.inspect}"

      test "Normal" do
        assert(comment_style == control_comment_style)
      end
    end
  end
end
