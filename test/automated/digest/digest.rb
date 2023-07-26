require_relative '../automated_init'

context "Digest" do
  digest = Output::Digest.new

  data = Controls::Data::Digest.example

  digest.update(data[0...1])
  digest.update(data[1..-1])

  detail "Data: #{data.inspect}"

  context "Get Digest" do
    digest = digest.digest
    control_digest = Controls::Data::Digest.digest

    comment Output::Digest.format(digest)
    detail "Control: #{Output::Digest.format(digest)}"

    test do
      assert(digest == control_digest)
    end
  end
end
