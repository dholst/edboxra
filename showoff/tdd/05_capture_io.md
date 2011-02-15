!SLIDE small transition=turnDown

# TDD #

## capture_io ##

	@@@ruby
	require 'minitest/autorun'
	require 'dog'
	
	class TestDog < MiniTest::Unit::TestCase
	  def setup
	    @dog = Dog.new
	  end
	
	  def test_speak
	    assert_output "bark\n", "" do
	      @dog.speak
	    end
	  end
	end

