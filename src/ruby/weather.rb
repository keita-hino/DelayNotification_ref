require 'net/http'
require 'uri'
require 'json'
require 'sqlite3'
require 'date'
require './notification'
require './api'


class Weather
  attr_accessor :city_name
  def initialize(city_name)
    @city_name = city_name
  end
  def get_weather


    #天気情報を市名で取得するパターン
    uri = URI.parse("http://api.openweathermap.org/data/2.5/find?q=#{city_name},jp&units=metric&APPID=#{weather_key}")

    #天気情報を緯度経度で取得するパターン
    #uri = URI.parse("http://api.openweathermap.org/data/2.5/find?lat=#{lat}&lon=#{lng}&cnt=1&APPID=#{weather_api_key}")

    json = Net::HTTP.get(uri)
    JSON.parse(json)
  end

  def weather_key
    weather_api_key = ENV['OPEN_WEATHER_APIKEY']
  end

  def get_direction(direction_no)
    case direction_no
      when 0..39 then wind_deg = "北"
      when 40..89 then wind_deg = "北東"
      when 90..139 then wind_deg = "東"
      when 140..179 then wind_deg = "南東"
      when 180..219 then wind_deg = "南"
      when 220..269 then wind_deg = "南西"
      when 270..309 then wind_deg = "西"
      when 310..360 then wind_deg = "北西"
    end
  end

  def get_stat(check_target)
    if check_target.nil?
      return true
    else
      return false
    end
  end
  def get_today_weather(eva_wind)
    weather_api_key = ENV['OPEN_WEATHER_APIKEY']
    result = []
    delay_date = []
    weather_hash = {}
    count = 0

    uri = URI.parse("http://api.openweathermap.org/data/2.5/forecast?q=#{city_name},jp&units=metric&APPID=#{weather_api_key}")
    json = Net::HTTP.get(uri)
    result.push(JSON.parse(json))
    # p result
    result[0]['list'][0].each do |list|
      weather_hash[result[0]['list'][count]['dt_txt']] = result[0]['list'][count]['wind']['speed']
      count = count + 1
    end
     weather_hash.each do |key,value|
      if eva_wind <= value then
        delay_date.push(key.gsub(" ","."))
      end
    end
    noti = Notifycation.new
    noti.line_notify(delay_date)

  end
end
