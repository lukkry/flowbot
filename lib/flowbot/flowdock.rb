require 'json'
require 'faraday'

module Flowbot
  module Flowdock
    def self.send_message(text, flow_token)
      return unless text

      body = {
        "content" => text,
        "external_user_name" => "Flowbot"
      }

      conn = Faraday.new(:url => "https://api.flowdock.com")
      conn.post do |req|
        req.url "/v1/messages/chat/#{flow_token}"
        req.headers['Content-Type'] = 'application/json'
        req.body = body.to_json
      end
    end
  end
end
