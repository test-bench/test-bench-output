require_relative '../automated_init'

context "Comment Style" do
  context "Get Disposition" do
    context "Style" do
      comment_style = Controls::CommentStyle.example

      control_disposition = Controls::CommentStyle.disposition

      disposition = CommentStyle.get_disposition(comment_style)

      comment disposition.inspect
      detail "Control: #{control_disposition.inspect}"

      test do
        assert(disposition == control_disposition)
      end
    end

    context "Incorrect Style" do
      incorrect_style = :incorrect_comment_style

      test "Is an error" do
        assert_raises(CommentStyle::Error) do
          CommentStyle.get_disposition(incorrect_style)
        end
      end
    end
  end
end
