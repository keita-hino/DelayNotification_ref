require './api'

class Notifycation

  def line_notify(delay_date)

    url = "https://notify-api.line.me/api/notify"
    api = Api.new(url)
    authorization = "Bearer #{line_accsess_key}"
    api.post(authorization,message(delay_date))

    return false
  end

  def line_accsess_key
    line_accsess_key = ENV['LINE_NOTIFY_KEY']
  end

  def message(delay_date)
    count = 0
    buf = get_buf(delay_date)
    message = <<-EOS
    #{buf.each do
      buf[count]
      count = count + 1
     end}
    EOS
  end

  def get_buf(delay_date)
    buf = []
    buf << "本日、下記の時間帯にJRが遅延する恐れがあります"
    delay_date.each do |msg|
      buf << msg
    end
    buf
  end

end
