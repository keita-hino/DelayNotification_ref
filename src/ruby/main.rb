require 'logger'
require 'date'
require 'net/http'
require 'uri'
require 'json'
require './weather'
require './Log'

 #ログの出力先を毎日変える
 path = "../../Log/#{Date.today}.txt"
 logger = Logger.new(path)
 CITY_NAME = 'Ishinomaki'
 #logger.info("処理開始")

 weather = Weather.new(CITY_NAME)
 log = Log.new

 # #ルート設定
 root_json = weather.get_weather["list"][0]

 #天気情報セット
 wind_speed = root_json["wind"]["speed"]
 wind_deg = weather.get_direction(root_json["wind"]["deg"])
 rain_check = weather.get_stat(root_json["rain"])
 snow_check = weather.get_stat(root_json["snow"])

# Log.create(:CreateDate => Date.today,:City_name => CITY_NAME,:Rain_check => rain_check,:Snow_check => snow_check,:Wind_deg => wind_deg,:Wind_speed => wind_speed)

buf = log.insert_weather(Date.today,CITY_NAME,rain_check,snow_check,wind_deg,wind_speed)

 # puts wind_speed
 # puts wind_deg
 # puts rain_check
 # puts snow_check


#風力の平均値取得
 # log = Log.new
 #
 # wind_avg = log.get_wind_avg
 # p wind_avg
