require 'net/http'
require 'uri'
require 'json'

class Api
  def get(url)
    uri = URI.parse(url)

    #天気情報を緯度経度で取得するパターン
    #uri = URI.parse("http://api.openweathermap.org/data/2.5/find?lat=#{lat}&lon=#{lng}&cnt=1&APPID=#{weather_api_key}")

    json = Net::HTTP.get(uri)
    JSON.parse(json)
  end
end
