require 'net/http'
require 'uri'
require 'json'

class Api
  attr_accessor :url
  def initialize(url)
    @url = url
  end
  def get_api
    uri = URI.parse(url)

    json = Net::HTTP.get(uri)
    JSON.parse(json)
  end

  def post(authorization,message)
    uri = URI.parse("https://notify-api.line.me/api/notify")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = authorization
    request.set_form_data(
      "message" => message,
    )

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end
end
