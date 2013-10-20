require 'json'
require 'faraday'

module Flowbot
  class MemeGenerator
    def self.url(meme, upper_text, lower_text)
      options = {
        u: "http://memecaptain.com/#{memes[meme]}.jpg",
        tt: upper_text.to_s.strip,
          tb: lower_text.to_s.strip
      }
      params = to_params(options)
      response = Faraday.get("http://v1.memecaptain.com/g?#{params}")
      JSON.parse(response.body)["imageUrl"]
    end

    def self.memes
      {
        "yuno" => "y_u_no",
      }
    end

    private

    def self.to_params(params)
      params.collect{ |k, v| "#{k}=#{v}" }.join("&")
    end
  end
end
