require_relative '../automated_init'

context "Digest" do
  context "Digest Predicate" do
    digest = Output::Digest.new

    control_data = Controls::Data::Digest.example

    digest.update(control_data[0...1])
    digest.update(control_data[1..-1])

    context "Data's Digest Corresponds" do
      context "Same Data" do
        data = control_data

        detail "Data: #{data.inspect}"

        digest_corresponds = digest.digest?(data)
        comment digest_corresponds.inspect

        test do
          assert(digest_corresponds)
        end
      end

      context "Different Data" do
        context "Same Length" do
          data = Controls::Data::Digest::Equivalent::SameLength.example

          detail "Data: #{data.inspect}"

          digest_corresponds = digest.digest?(data)
          comment digest_corresponds.inspect

          test do
            assert(digest_corresponds)
          end
        end

        context "Different Length" do
          data = Controls::Data::Digest::Equivalent::DifferentLength.example

          detail "Data: #{data.inspect}"

          digest_corresponds = digest.digest?(data)
          comment digest_corresponds.inspect

          test do
            assert(digest_corresponds)
          end
        end
      end
    end

    context "Data's Digest Doesn't Correspond" do
      data = Controls::Data.random
      detail "Data: #{data.inspect}"

      digest_corresponds = digest.digest?(data)

      comment digest_corresponds.inspect

      test do
        refute(digest_corresponds)
      end
    end
  end
end
