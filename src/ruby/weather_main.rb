require 'logger'
require 'date'
require 'net/http'
require 'uri'
require 'json'
require './weather'
require './Log'

system_log = Logger.new("../../Log/JRDelay_#{Date.today}.log")
system_log.info("天気記録開始")

CITY_NAME = 'Ishinomaki'
weather = Weather.new(CITY_NAME)

# #ルート設定
root_json = weather.get_weather["list"][0]

#天気情報セット
wind_speed = root_json["wind"]["speed"]
wind_deg = weather.get_direction(root_json["wind"]["deg"])
rain_check = weather.get_stat(root_json["rain"]).to_s
snow_check = weather.get_stat(root_json["snow"]).to_s

log = Log.new(
  CreateDate:Date.today,
  City_Name:CITY_NAME,
  Rain_Check:rain_check,
  Snow_Check:snow_check,
  Wind_Deg:wind_deg,
  Wind_Speed:wind_speed
)
 log.save

system_log.info("処理終了")
puts "#{Date.today}:天気情報記録完了"

# 風速の平均値取得
# puts Log.average(:Wind_Speed)
