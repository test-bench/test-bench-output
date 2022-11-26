require_relative '../../automated_init'

context "Writer" do
  context "Follow" do
    context "Alternate Device" do
      context "Preceding Writer Has a Peer" do
        peer_writer = Output::Writer.new

        preceding_writer = Output::Writer.new
        preceding_writer.peer = peer_writer

        writer = Output::Writer.follow(preceding_writer)

        context "Alternate Device" do
          alternate_device = writer.alternate_device

          test "Is the preceding writer's peer" do
            assert(alternate_device == peer_writer)
          end
        end
      end

      context "Preceding Writer Doesn't Have a Peer" do
        preceding_writer = Output::Writer.new

        writer = Output::Writer.follow(preceding_writer)

        context "Alternate Device" do
          alternate_device = writer.alternate_device

          test "Null device" do
            assert(alternate_device.instance_of?(Output::Device::Null))
          end
        end
      end
    end
  end
end
