module TestBench
  class Output
    module Controls
      module Detail
        def self.example = TestBench::Output::Detail.on
        def self.other_example = TestBench::Output::Detail.off

        def self.random
          details = [
            TestBench::Output::Detail.on,
            TestBench::Output::Detail.off,
            TestBench::Output::Detail.failure
          ]

          index = Random.integer % details.count

          details[index]
        end
      end
    end
  end
end
