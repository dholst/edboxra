require 'minitest/autorun'
require 'edboxra'

class TestEdboxra < MiniTest::Unit::TestCase
  def setup
    @api = Edboxra::ApiFactory.create_api
  end

  def test_get_movies
    movies = @api.get_movies
    assert(movies.length > 0)
  end
end
