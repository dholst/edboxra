module Edboxra
  class Version1Api < Api
    KEY_REGEX = /__K.*value="(.*)"/

    def self.build_from(response)
      self.new if KEY_REGEX.match(response)
    end
  end
end
