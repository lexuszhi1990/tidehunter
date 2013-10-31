require 'net/http'
require 'json'

class Weixin

  def self.school_uri(search_key = nil)
    url = 'http://gogograd.com/api/v1/weixin.json?search%5Bname_or_zh_name_contains%5D=#{search_key}'
    URI.encode(url.strip)
  end

  def self.http_getor(key)
      data = Net::HTTP.get(URI.parse(school_uri(key)))
      JSON.parse(data).first if data
  end

end
