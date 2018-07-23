require './log'
require './Evaluation'
require './Weather'
require 'Date'

time = Time.now

system_log = Logger.new("../../Log/JRDelay_#{Date.today}.log")
system_log.info("通知処理開始")

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

  system_log.info("通知処理終了")
  puts "#{Date.today}:通知処理完了"

  puts "処理時間計測#{Time.now-time}"
