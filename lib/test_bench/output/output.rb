module TestBench
  module Output
    def self.included(cls)
      cls.class_exec do
        extend Build
      end
    end

    def writer
      @writer ||= Writer::Substitute.build
    end
    attr_writer :writer

    def configure(device: nil, styling: nil)
      Writer.configure(self, device:, styling:)
    end

    module Build
      def build(device: nil, styling: nil, **arguments)
        instance = new
        instance.configure(device:, styling:, **arguments)
        instance
      end
    end
  end
end
