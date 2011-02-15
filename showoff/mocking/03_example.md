!SLIDE small transition=turnDown

# Mocking #

	@@@ruby
	require 'minitest/autorun'
	require 'minitest/mock'
	
	describe Library do
	  before do
	    @repo = MiniTest::Mock.new
	    @library = Library.new(@repo)
	  end
	
	  it "should find books by name" do
	    book = Book.new
	    @repo.expect :find, book, ["Minitest In Action"]
	
	    book_found = @library.find_book "Minitest In Action"
	
	    book_found.must_be_same_as book
	  end
	end

