require 'json'
require 'date'

module Edboxra
  class Version1Api < Api
    KEY_REGEX = /__K.*value="(.*)"/

    def self.build_from(response)
      match = KEY_REGEX.match(response.body)
      self.new(match[1], response.headers[:set_cookie]) if match
    end

    def get_movies
      resp = RestClient.get("http://www.redbox.com/data.svc/Title/js")

      match = /=\ *(\[.*\]);/.match(resp.body)
      raise "couldn't find movies in #{resp.body}" unless match

      json = JSON.parse(match[1])

      json.map do |row|
        movie = Movie.new
        movie.id = row["ID"]
        movie.name = row["Name"]
        movie.release_date = Date.parse(row['Release'])
        movie.image = row["Img"]
        movie.genre_ids = row["GenreIDs"]
        movie.blu_ray = row["FormatID"].eql? "2"
        movie
      end
    end

    def add_metadata_to(movie)
      postData = JSON.generate({
        :type => "Title",
        :pk => "ID",
        :statements => [{:filters => {:ID => movie.id}}],
        "__K" => @key
      })

      headers = {
        'Cookie' => @cookies.map{|k,v| "#{k}=#{v}"}.join("; "),
      }

      resp = RestClient.post("http://www.redbox.com/data.svc/Title", postData, headers)

      match = /\{.*?\:(.*)\}/.match(resp.body)
      raise "couldn't find metadata in #{resp.body}" unless match

      json = JSON.parse(match[1])

      movie.description = json["Desc"]
      movie.rating = json["Rating"]
      movie.running_time = json["RunningTime"]
      movie.genre = json["Genre"]
      movie.actors = json["Actors"]
    end
  end
end
