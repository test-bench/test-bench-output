require_relative '../automated_init'

context "Writer" do
  context "TTY Predicate" do
    context "Device Is Associated With a Terminal" do
      device = Controls::Device::TTY.example

      writer = Output::Writer.new
      writer.device = device

      test "Affirmative" do
        assert(writer.tty?)
      end
    end

    context "Device Isn't Associated With a Terminal" do
      device = Controls::Device::TTY::Non.example

      writer = Output::Writer.new
      writer.device = device

      test "Negative" do
        refute(writer.tty?)
      end
    end
  end
end
