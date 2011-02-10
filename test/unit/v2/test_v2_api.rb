require 'test_helper'

describe Edboxra::V2::Api do
  MOVIES_JS = 'var __titles = [{"ID":3942,"soon":"0","name":"Red Hill","SEO":"red-hill","sortName":"red hill","img":"RedHill_3942.jpg","release":"20110125","releaseDays":16,"genreIDs":[1000,1003],"fmt":"1","productType":"1","rating":"R","def":"1","limited":"0"},{"ID":3956,"soon":"0","name":"Saw: The Final Chapter","SEO":"saw--the-final-chapter","sortName":"saw: the final chapter","img":"SawVII_3956.jpg","release":"20110125","releaseDays":16,"genreIDs":[1009,1020,1093],"fmt":"1","productType":"1","rating":"R","def":"1","limited":"0"},{"ID":4385,"soon":"0","name":"Takers (BLU-RAY)","SEO":"takers-blu-ray","sortName":"takers (blu-ray)","img":"TakersBLURAY_4385.jpg","release":"20110118","releaseDays":23,"genreIDs":[1000,1003,1022],"fmt":"2","productType":"1","rating":"R","def":"1","limited":"0"}]'

  before do
    FakeBox.fakeout_version_2
    FakeBox.expect_get("http://www.redbox.com/api/product/js/__titles", MOVIES_JS)
    @api = Edboxra::ApiFactory.create_api
  end

  it "should get a list of movies" do
    movies = @api.get_movies

    movies.size.must_equal 3

    red_hill = movies[0]
    red_hill.id.must_equal 3942
    red_hill.name.must_equal "Red Hill"
    red_hill.release_date.to_s.must_equal "2011-01-25"
    red_hill.image.must_equal "RedHill_3942.jpg"
    red_hill.genre_ids.must_equal [1000, 1003]
    red_hill.blu_ray?.must_equal false
  end

  it "should parse blu ray movies" do
    movies = @api.get_movies

    takers = movies[2]
    takers.id.must_equal 4385
    takers.blu_ray?.must_equal true
  end
end

