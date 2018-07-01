require 'logger'
require 'date'
require './weather'
require './Log'

system_log = Logger.new("../../Log/JRDelay_#{Date.today}.log")
system_log.info("天気記録開始")

CITY_NAME = 'Ishinomaki'
weather = Weather.new(CITY_NAME)

weather.insert_weather_log

system_log.info("処理終了")
puts "#{Date.today}:天気情報記録完了"

# 風速の平均値取得
# puts Log.average(:Wind_Speed)
