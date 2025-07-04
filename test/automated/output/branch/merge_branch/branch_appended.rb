require_relative '../../../automated_init'

context "Branch" do
  context "Merge Branch" do
    context "Branch Appended" do
      branch = Branch.new

      other_branch = Branch.new

      branch.merge(other_branch)

      entries = branch.entries
      detail "Entries: #{entries.inspect}"

      appended = entries.include?(other_branch)

      test do
        assert(appended)
      end
    end
  end
end
