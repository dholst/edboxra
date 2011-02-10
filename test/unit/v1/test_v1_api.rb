require 'test_helper'

class TestV1Api < TestCase
  MOVIES_JS = 'Type.registerNamespace(\'rb.Cache\'); rb.Cache.__Title = [{"Cst":"0","ID":3942,"Name":"Red Hill","SortName":"red hill","Img":"RedHill_3942.jpg","Release":"20110125","GenreIDs":[1000,1003],"FormatID":"1","ProductType":"1","Def":"1","Limited":"0"},{"Cst":"0","ID":3956,"Name":"Saw: The Final Chapter","SortName":"saw: the final chapter","Img":"SawVII_3956.jpg","Release":"20110125","GenreIDs":[1009,1020,1093],"FormatID":"1","ProductType":"1","Def":"1","Limited":"0"},{"Cst":"0","ID":4385,"Name":"Takers (BLU-RAY)","SortName":"takers (blu-ray)","Img":"TakersBLURAY_4385.jpg","Release":"20110118","GenreIDs":[1000,1003,1022],"FormatID":"2","ProductType":"1","Def":"1","Limited":"0"}];'

  def setup
    FakeBox.fakeout_version_1
    FakeBox.expect_get("http://www.redbox.com/data.svc/Title/js", MOVIES_JS)
    @api = Edboxra::ApiFactory.new(LogStub.new).create_api
  end

  def test_get_movies
    movies = @api.get_movies

    assert_equal(3, movies.size)

    assert_equal(3942, movies[0].id)
    assert_equal("Red Hill", movies[0].name)
    assert_equal("2011-01-25", movies[0].release_date.to_s)
    assert_equal("RedHill_3942.jpg", movies[0].image)
    assert_equal([1000, 1003], movies[0].genre_ids)
    refute(movies[0].blu_ray?)
  end

  def test_get_blu_ray_movies
    movies = @api.get_movies

    assert_equal(4385, movies[2].id)
    assert_equal("Takers (BLU-RAY)", movies[2].name)
    assert(movies[2].blu_ray?)
  end

  def test_add_metadata
    expected_content = JSON.generate({
      :type => "Title",
      :pk => "ID",
      :statements => [{:filters => {:ID => 3942}}],
      "__K" => "version_1_key"
    })

    expected_headers = {
      :Cookie => 'redboxVersion=foo'
    }

    expected_response = '{"d":{"ID":4488,"Cst":"0","Name":"Big Momma\u0027s House (2000)","Img":"BigMommasHouse2000_4488.jpg","QtyRange":0,"Buy":"0","Price":7.0000,"Rating":"PG-13","RunningTime":"01:40","Actors":"Martin Lawrence, Nia Long","YahooRating":"B-","Desc":"Disguise is the limit. \"Martin Lawrence brings down the house\" (E! Online) as crafty FBI agent Malcolm Turner who\u0027s willing to go through thick and thin in order to catch an escaped prisoner. Sherry (Nia Long), the con\u0027s sexy former flame - she might have the skinny on millions in stolen loot, and she\u0027s headed for Georgia to lay low for a while. That\u0027s enough to send Malcolm deep undercover as Big Momma, an oversized, overbearing Southern granny with an attitude as tough as her pork chops. The result is an outrageous comedy of epic proportions, filled with nonstop laughs and plenty of action!  \r\n \r\nRated PG-13 by the Motion Picture Association of America for crude humor including sexual innuendo, and for language and some violence. ","Genre":"Comedy","FormatID":"1","FormatName":"DVD","ProductType":"1","GameInstructionsURL":"","Trailers":{},"Ranks":{},"ReleaseDate":"February 08, 2011","Inv":null,"BuyDVDUrl":"","BuyBluRayUrl":"","Limited":"0"}}'

    FakeBox.expect_post("http://www.redbox.com/data.svc/Title", expected_content, expected_headers, expected_response)

    movies = @api.get_movies
    red_hill = movies[0]
    assert_nil(red_hill.description)

    @api.add_metadata_to(red_hill)

    refute_nil(red_hill.description)
    assert_equal("PG-13", red_hill.rating)
    assert_equal("01:40", red_hill.running_time)
    assert_equal("Comedy", red_hill.genre)
    assert_equal("Martin Lawrence, Nia Long", red_hill.actors)
  end
end
