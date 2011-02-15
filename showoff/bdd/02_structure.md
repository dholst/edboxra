!SLIDE transition=turnDown

# BDD #

	@@@ruby
	require 'minitest/autorun'
	
	describe Post do
	  before do
	    @post = Post.new("minitest rockz")
	  end
	
	  it "should set the title" do
	    @post.title.must_equal "minitest rockz"
	  end
	end

