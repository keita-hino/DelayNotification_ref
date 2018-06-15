require 'active_record'

ActiveRecord::Base.establish_connection(
    "adapter" =>"sqlite3",
    "database" => "../../DB/weather_db/Ishinomaki.db"
)

class Log < ActiveRecord::Base #import.sqlのテーブル名postsを大文字、単数形に変える
  def get_wind_avg
    wind_array = []
    wind_speed = []

    wind_array.push(Log.select(:Wind_Speed))

    wind_array[0].each do |spped|
      wind_speed.push(spped[:Wind_Speed].to_f)
    end
    wind_speed.sum / wind_speed.length
  end
  def insert_weather(today,city_name,rain_check,snow_check,wind_deg,wind_speed)
    puts today
    puts city_name
    puts rain_check
    puts snow_check
    puts wind_deg
    puts wind_speed
#    User.create(name: 'user1', age: 27)
    #Log.create(CreateDate: today ,City_name: city_name ,Rain_check: rain_check ,Snow_check: snow_check,Wind_deg: wind_deg,Wind_speed: wind_speed)

    # p Log.create(:CreateDate => today,:City_name => city_name,:Rain_check => rain_check,:Snow_check => snow_check,:Wind_deg => wind_deg,:Wind_speed => wind_speed)
      # p Log.create(:CreateDate => today,:City_name => city_name,:Rain_check => rain_check,:Snow_check => snow_check,:Wind_deg => wind_deg,:Wind_speed => wind_speed)
     return
  end

end



#class DB >
