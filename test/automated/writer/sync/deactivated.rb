require_relative '../../automated_init'

context "Writer" do
  context "Sync" do
    context "Deactivated" do
      writer = Output::Writer.new
      writer.sync = true

      writer.sync = false

      sync = writer.sync

      test! do
        refute(sync)
      end
    end
  end
end
