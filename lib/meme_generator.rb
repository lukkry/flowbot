require 'json'
require 'faraday'

class MemeGenerator
  def self.url(meme, upper_text, lower_text)
    options = {
      u: "http://memecaptain.com/#{meme}.jpg",
      tt: upper_text,
      tb: lower_text
    }
    params = to_params(options)
    response = Faraday.get("http://v1.memecaptain.com/g?#{params}")
    JSON.parse(response.body)["imageUrl"]
  end

  private

  def self.to_params(params)
    params.collect{ |k, v| "#{k}=#{v}" }.join("&")
  end
end
