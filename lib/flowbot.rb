require 'eventmachine'
require 'em-http'
require 'json'

class Flowbot
  def self.run(token, flow_token, organization, flow)
    http = EM::HttpRequest.new("https://stream.flowdock.com/flows/#{organization}/#{flow}")
    push_url = "https://api.flowdock.com/v1/messages/chat/#{flow_token}"
    EventMachine.run do
      s = http.get(:head => { 'Authorization' => [token, ''], 'accept' => 'application/json'}, :keepalive => true, :connect_timeout => 0, :inactivity_timeout => 0)

      buffer = ""
      s.stream do |chunk|
        buffer << chunk
        while line = buffer.slice!(/.+\r\n/)
          msg = JSON.parse(line)["content"]

          if msg =~ /^\@f hello$/
            body = {
              "content" => "echo",
              "external_user_name" => "lukkry"
            }
            EventMachine::HttpRequest.new(push_url).post :body => body
          end
        end
      end
    end
  end
end
