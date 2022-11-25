module TestBench
  class Output
    module Controls
      module Output
        def self.example(details: nil, styling: nil, mode: nil)
          styling ||= false

          output = TestBench::Output.new

          if details == true
            output.detail_policy = TestBench::Output::Detail.on
          elsif details == false
            output.detail_policy = TestBench::Output::Detail.off
          else
            output.detail_policy = TestBench::Output::Detail.failure
          end

          if styling
            output.writer.styling!
          end

          if not mode.nil?
            output.mode = mode
          end

          output
        end

        module Styling
          def self.example
            Output.example(styling: true)
          end
        end
      end
    end
  end
end
