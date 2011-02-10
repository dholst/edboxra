require 'restclient'
require 'logger'

module Edboxra
  class ApiFactory
    def initialize(logger = nil)
      @log = logger || Logger.new(STDOUT)
    end

    def create_api
      response = RestClient.get("http://www.redbox.com")

      try_version(V1::Api, response) ||
      try_version(V2::Api, response)
    end

    private

    def try_version(version, response)
      match = version::KEY_REGEX.match(response.body)

      if(match)
        @log.debug("found api key -- #{match[1]}")
        version.new(match[1], response.headers[:set_cookie]) if match
      end
    end
  end
end
