require 'edboxra/version'
require 'edboxra/api_factory'
require 'edboxra/api'
require 'edboxra/movie'
require 'edboxra/v1/v1_api'
require 'edboxra/v2/v2_api'

module Net::HTTPHeader
  def capitalize(name)
    return "__K" if name.eql? "__k"
    name.split(/-/).map {|s| s.capitalize }.join('-')
  end
end

