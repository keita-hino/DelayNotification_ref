class Notifycation

  def line_notify(delay_date)
    buf = []
    count = 0
    line_accsess_key = ENV['LINE_NOTIFY_KEY']

    buf << "本日、下記の時間帯にJRが遅延する恐れがあります"
    delay_date.each do |msg|
      buf << msg
    end
    message = <<-EOS
    #{buf.each do
      buf[count]
      count = count + 1
     end}
    EOS

    uri = URI.parse("https://notify-api.line.me/api/notify")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{line_accsess_key}"
    request.set_form_data(
      "message" => "#{message}",
    )

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    return false
  end

end
