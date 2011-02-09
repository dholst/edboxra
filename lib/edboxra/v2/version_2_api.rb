module Edboxra
  class Version2Api < Api
    KEY_REGEX = /rb\.api\.key *= * [',"](.*?)[',"]/

    def self.build_from(response)
      match = KEY_REGEX.match(response.body)
      self.new(match[1], response.headers[:set_cookie]) if match
    end
  end
end
