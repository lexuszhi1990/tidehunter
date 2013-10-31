require 'net/http'
require 'json'

class Weixin
  def self.http_get(key)
      data = RestClient.get("http://gogograd.com/api/v1/weixin.json", :params => {"search[name_or_zh_name_contains]" => key.strip.to_s})
      JSON.parse(data)
  end
end
