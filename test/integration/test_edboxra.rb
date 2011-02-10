require 'minitest/autorun'
require 'edboxra'

class TestEdboxra < MiniTest::Unit::TestCase
  def setup
    @api = Edboxra::ApiFactory.new.create_api
  end

  def test_get_movies
    movies = @api.get_movies
    assert(movies.length > 0)
    p "found #{movies.length} movies"

    some_movie = movies[500]
    @api.add_metadata_to(some_movie)
    p some_movie
  end
end
