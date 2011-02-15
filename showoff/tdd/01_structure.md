!SLIDE small transition=turnDown

# TDD #

## classic xunit ##

	@@@ ruby
	require 'minitest/autorun'
	require 'post'
	
	class TestPost < MiniTest::Unit::TestCase
	  def setup
	    @post = Post.new("minitest rockz")
	  end
	
	  def test_title
	    assert_equal("minitest rockz", @post.title)
	  end
	end

