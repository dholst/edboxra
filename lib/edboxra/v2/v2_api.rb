require 'date'
require 'json'

module Edboxra
  module V2
    class Api < Edboxra::Api
      KEY_REGEX = /rb\.api\.key *= * [',"](.*?)[',"]/

      def get_movies
        resp = RestClient.get("http://www.redbox.com/api/product/js/__titles")

        match = /=\ *(\[.*\])/.match(resp.body)
        raise "couldn't find movies in #{resp.body}" unless match

        json = JSON.parse(match[1])
        json.map{|movie| map_movie(movie)}
      end

      def add_metadata_to(movie)
      end

      private

      def map_movie(json)
        movie = Movie.new
        movie.id = json["ID"]
        movie.name = json["name"]
        movie.release_date = Date.parse(json['release'])
        movie.image = json["img"]
        movie.genre_ids = json["genreIDs"]
        movie.blu_ray = json["fmt"].eql? "2"
        movie
      end
    end
  end
end
