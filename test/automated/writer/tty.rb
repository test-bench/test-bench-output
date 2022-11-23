require_relative '../automated_init'

context "Writer" do
  context "TTY Predicate" do
    context "Device Is Associated With a Terminal" do
      device = Controls::Device::TTY.example

      context do
        writer = Output::Writer.new
        writer.device = device

        test "Affirmative" do
          assert(writer.tty?)
        end
      end

      context "Overridden" do
        writer = Output::Writer.new
        writer.device = device
        writer.tty = false

        test "Negative" do
          refute(writer.tty?)
        end
      end
    end

    context "Device Isn't Associated With a Terminal" do
      device = Controls::Device::TTY::Non.example

      context do
        writer = Output::Writer.new
        writer.device = device

        test "Negative" do
          refute(writer.tty?)
        end
      end

      context "Overridden" do
        writer = Output::Writer.new
        writer.device = device
        writer.tty = true

        test "Affirmative" do
          assert(writer.tty?)
        end
      end
    end
  end
end
