require 'eventmachine'
require 'em-http'
require 'json'
require 'meme_matcher'

class Flowbot
  def self.respond_to(message)
    return unless message.is_a?(String)

    matches = message.match(/^\@f\s+(\w+)/)
    if matches && self.respond_to?(matches[1])
      message = message.sub(/^\@f\s+#{matches[1]}/, "").strip
        self.send(matches[1], message)
    end
  end

  def self.meme(message)
    MemeMatcher.match(message)
  end

  def self.run(token, flow_token, organization, flow)
    http = EM::HttpRequest.new("https://stream.flowdock.com/flows/#{organization}/#{flow}")
    push_url = "https://api.flowdock.com/v1/messages/chat/#{flow_token}"
    EventMachine.run do
      s = http.get(:head => { 'Authorization' => [token, ''], 'accept' => 'application/json'}, :keepalive => true, :connect_timeout => 0, :inactivity_timeout => 0)

      buffer = ""
      s.stream do |chunk|
        buffer << chunk
        while line = buffer.slice!(/.+\r\n/)
          message = JSON.parse(line)["content"]
          response = respond_to(message)
          if response
            body = {
              "content" => response,
              "external_user_name" => "lukkry"
            }
          end
          EventMachine::HttpRequest.new(push_url).post :body => body
        end
      end
    end
  end
end
