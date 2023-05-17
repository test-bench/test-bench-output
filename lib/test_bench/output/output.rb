module TestBench
  module Output
    def self.included(cls)
      cls.class_exec do
        include Telemetry::Sink::Handler

        extend Build
        extend RegisterTelemetry
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

    module RegisterTelemetry
      def register_telemetry(telemetry, **arguments)
        instance = build(**arguments)
        telemetry.register(instance)
        instance
      end
      alias :register :register_telemetry
    end
  end
end
