require './log'
require './Evaluation'
require './Weather'
require 'Date'

log = Log.new

weather_avg = Log.average(:Wind_Speed)
evaluation = Evaluation.new(
  Wind_Avg:weather_avg.round(2),
  Create_Date:Date.today
)
evaluation.save
eva_wind =  Evaluation.select("Wind_Avg").last.Wind_Avg

CITY_NAME = 'Ishinomaki'
weather = Weather.new(
  CITY_NAME
)

  delay_time = weather.get_today_weather(eva_wind)
  puts delay_time
# #ルート設定
# root_json = weather.get_weather["list"][0]

#天気情報セット
# wind_speed = root_json["wind"]["speed"]
# wind_deg = weather.get_direction(root_json["wind"]["deg"])
# rain_check = weather.get_stat(root_json["rain"]).to_s
# snow_check = weather.get_stat(root_json["snow"]).to_s
#
#
# puts weather.get_today_weather
