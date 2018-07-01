require 'date'
require './notification'
require './api'
require './Log'

class Weather
  attr_accessor :city_name
  def initialize(city_name)
    @city_name = city_name
  end

  def insert_weather_log
    url = "http://api.openweathermap.org/data/2.5/find?q=#{city_name},jp&units=metric&APPID=#{weather_key}"
    api = Api.new(url)

    # #ルート設定
    @root_json = api.get_api["list"][0]

    log = Log.new(
      CreateDate:Date.today,
      City_Name:city_name,
      Rain_Check:rain_check,
      Snow_Check:snow_check,
      Wind_Deg:wind_deg,
      Wind_Speed:wind_speed
    )
     log.save
  end

  def wind_speed
    @root_json["wind"]["speed"]
  end

  def wind_deg
    get_direction(@root_json["wind"]["deg"])
  end

  def rain_check
    get_stat(@root_json["rain"]).to_s
  end

  def snow_check
    get_stat(@root_json["snow"]).to_s
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
    delay_date = []
    weather_hash = {}
    count = 0
    url = "http://api.openweathermap.org/data/2.5/forecast?q=#{city_name},jp&units=metric&APPID=#{weather_key}"
    api = Api.new(url)

    json = api.get_api['list']
    json[0].each do |list|
      if eva_wind <= json[count]['wind']['speed'] then
        delay_date.push(json[count]['dt_txt'].gsub(" ","."))
      end
      count = count + 1
    end

    noti = Notifycation.new
    noti.line_notify(delay_date)
  end

end
