require 'active_record'

ActiveRecord::Base.establish_connection(
    "adapter" =>"sqlite3",
    "database" => "../../DB/weather_db/Ishinomaki.db"
)

class Post < ActiveRecord::Base #import.sqlのテーブル名postsを大文字、単数形に変える
  def insert_weather

  end
end

#p Post.all.select(:Wind_Avg)
p Post.all

#class DB >
