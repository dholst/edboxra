!SLIDE small

# Benchmarking #

	@@@ruby
	require 'minitest/benchmark' if ENV["BENCH"]
	require 'minitest/autorun'
	
	class TestSecretStuff < MiniTest::Unit::TestCase
	  # Override self.bench_range
	  # default range is [1, 10, 100, 1_000, 10_000]
	
	  def bench_my_algorithm
	    assert_performance_linear 0.9999 do |n|
	      n.times do
	        @obj.my_algorithm
	      end
	    end
	  end
	end

