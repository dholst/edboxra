require 'restclient'

module Edboxra
  class ApiFactory
    def self.create_api
      response = RestClient.get("http://www.redbox.com")

      try_version(V1::Api, response) ||
      try_version(V2::Api, response)
    end

    private

    def self.try_version(version, response)
      match = version::KEY_REGEX.match(response.body)
      version.new(match[1], response.headers[:set_cookie]) if match
    end
  end
end
