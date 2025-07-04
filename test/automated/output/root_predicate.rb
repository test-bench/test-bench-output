require_relative '../automated_init'

context "Output" do
  context "Root Predicate" do
    context "Affirmative" do
      context "Branch Stack Is Empty" do
        output = Output.new

        test do
          assert(output.root?)
        end
      end

      context "Branch Stack Isn't Empty" do
        output = Output.new

        branch = Branch.new
        output.branches << branch

        test do
          refute(output.root?)
        end
      end
    end
  end
end
