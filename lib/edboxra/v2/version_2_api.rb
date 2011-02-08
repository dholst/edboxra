module Edboxra
  class Version2Api < Api
    KEY_REGEX = /rb\.api\.key *= * [',"](.*?)[',"]/

    def self.build_from(response)
      self.new if KEY_REGEX.match(response)
    end
  end
end
