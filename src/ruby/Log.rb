require 'active_record'
require 'date'

ActiveRecord::Base.establish_connection(
    "adapter" =>"sqlite3",
    "database" => "../../DB/weather_db/Ishinomaki.db"
)

class Log < ActiveRecord::Base #import.sqlのテーブル名postsを大文字、単数形に変える
end

#class DB >
