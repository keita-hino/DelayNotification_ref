require 'active_record'

ActiveRecord::Base.establish_connection(
    "adapter" =>"sqlite3",
    "database" => "../../DB/weather_db/Ishinomaki.db"
)

class Evaluation < ActiveRecord::Base #import.sqlのテーブル名postsを大文字、単数形に変える
end

#class DB >
