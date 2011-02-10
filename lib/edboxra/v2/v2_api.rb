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
        postData = JSON.generate({
          :productType => 1,
          :id => movie.id,
          :descCharLimit => 2000
        })

        response = RestClient.post("http://www.redbox.com/api/Product/GetDetail/", postData, post_headers)
        map_metadata(movie, JSON.parse(response.body))
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

      def map_metadata(movie, json)
        if(json["d"] && json["d"]["success"] && json["d"]["data"])
          data = json["d"]["data"]
          movie.description = data["desc"]
          movie.rating = data["rating"]
          movie.running_time = data["len"]
          movie.genre = (data["genre"] || []).join(", ")
          movie.actors = (data["starring"] || []).join(", ")
        else
          raise "no metadata - " + resp
        end
      end

      def post_headers
        {'Cookie' => @cookies.map{|k,v| "#{k}=#{v}"}.join("; "), "__K" => @key}
      end
    end
  end
end
