require_relative '../../automated_init'

context "Device Substitute" do
  context "TTY Predicate" do
    context "Affirmative" do
      substitute = Controls::Device::TTY.example

      tty = substitute.tty?

      test do
        assert(tty)
      end
    end

    context "Negative" do
      substitute = Controls::Device::TTY::Non.example

      tty = substitute.tty?

      test do
        refute(tty)
      end
    end
  end
end
