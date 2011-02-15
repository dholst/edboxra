!SLIDE small transition=turnDown

# TDD #

## skip, pass, flunk ##

	@@@ruby
	require 'minitest/autorun'
	
	class TestFoo < MiniTest::Unit::TestCase
	  def test_skip
	    skip "can't figure why it's failing and it's 4pm"
	    assert_equal 1, 2
	  end
	
	  def test_flunk
	    flunk "forced failure"
	  end
	
	  def test_pass
	    1000.times {pass "I get paid per assertion"}
	  end
	end

