require 'json'
require 'date'

module Edboxra
  module V1
    class Api < Edboxra::Api
      KEY_REGEX = /__K.*value="(.*)"/

      def get_movies
        resp = RestClient.get("http://www.redbox.com/data.svc/Title/js")

        match = /=\ *(\[.*\]);/.match(resp.body)
        raise "couldn't find movies in #{resp.body}" unless match

        json = JSON.parse(match[1])
        json.map{|movie| map_movie(movie)}
      end

      def add_metadata_to(movie)
        postData = JSON.generate({
          :type => "Title",
          :pk => "ID",
          :statements => [{:filters => {:ID => movie.id}}],
          "__K" => @key
        })

        response = RestClient.post("http://www.redbox.com/data.svc/Title", postData, post_headers)
        map_metadata(movie, JSON.parse(response_object_from(response.body)))
      end

      private

      def post_headers
        {'Cookie' => @cookies.map{|k,v| "#{k}=#{v}"}.join("; ")}
      end

      def response_object_from(json)
        match = /\{.*?\:(.*)\}/.match(json)
        raise "couldn't find response object in #{json}" unless match
        match[1] if match
      end

      def map_movie(json)
        movie = Movie.new
        movie.id = json["ID"]
        movie.name = json["Name"]
        movie.release_date = Date.parse(json['Release'])
        movie.image = json["Img"]
        movie.genre_ids = json["GenreIDs"]
        movie.blu_ray = json["FormatID"].eql? "2"
        movie
      end

      def map_metadata(movie, json)
        movie.description = json["Desc"]
        movie.rating = json["Rating"]
        movie.running_time = json["RunningTime"]
        movie.genre = json["Genre"]
        movie.actors = json["Actors"]
      end
    end
  end
end
