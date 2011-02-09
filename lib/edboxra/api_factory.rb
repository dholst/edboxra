require 'restclient'

module Edboxra
  class ApiFactory
    def self.create_api
      resp = RestClient.get("http://www.redbox.com")
      Version1Api.build_from(resp) || Version2Api.build_from(resp)
    end
  end
end
