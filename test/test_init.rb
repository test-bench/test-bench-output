require_relative '../init'

require 'test_bench/isolated'; TestBenchIsolated::TestBench.activate

require 'test_bench/output/controls'

include TestBench

Controls = TestBench::Output::Controls rescue nil
