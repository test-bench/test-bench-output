require_relative '../../automated_init'

context "Device Substitute" do
  context "TTY Predicate" do
    context "Affirmative" do
      substitute = Device::Substitute.build

      substitute.set_tty

      tty = substitute.tty?

      test do
        assert(tty)
      end
    end

    context "Negative" do
      substitute = Device::Substitute.build

      tty = substitute.tty?

      test do
        refute(tty)
      end
    end
  end
end
