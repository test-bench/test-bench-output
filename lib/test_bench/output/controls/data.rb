module TestBench
  class Output
    module Controls
      module Data
        def self.example(suffix=nil)
          suffix = "-#{suffix}" if not suffix.nil?

          "some-data#{suffix}"
        end
        def self.random = example(Random.string)

        module Digest
          def self.example
            '0123456789:;<=>'
          end

          def self.digest
            0x3031323334353637 + 0x0038393A3B3C3D3E
          end

          module Equivalent
            module SameLength
              def self.example
                '0123456789:;<=>'
              end

              def self.digest = Digest.digest
            end

            module DifferentLength
              def self.example
                [Digest.digest].pack('Q>')
              end

              def self.digest = Digest.digest
            end
          end
        end
      end
    end
  end
end
