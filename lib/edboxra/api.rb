module Edboxra
  class Api
    def initialize(key, cookies)
      @key = key
      @cookies = parse_cookies(cookies)
    end

    private

    def parse_cookies(cookies)
      out = {}

      [cookies].flatten.each do |raw_cookie|
        raw_cookie.split(";").each do |cookie_part|
          key, val = cookie_part.strip.split("=", 2)

          unless %w(expires domain path secure HttpOnly).member?(key)
            out[key] = val
          end
        end
      end

      out
    end
  end
end
