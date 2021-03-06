require 'eventmachine'
require 'em-http'
require 'json'
require 'flowbot/flowdock'
require 'flowbot/meme_matcher'
require 'flowbot/logger'

module Flowbot
  def self.run(token, flow_token, organization, flow)
    http = EM::HttpRequest.new("https://stream.flowdock.com/flows/#{organization}/#{flow}")
    EventMachine.run do
      s = http.get(head: { 'Authorization' => [token, ''], 'accept' => 'text/event-stream'},
                   keepalive: true, connect_timeout: 0, inactivity_timeout: 0)

      buffer = ""
      s.stream do |chunk|
        buffer << chunk
        while line = buffer.slice!(/.+\n\n/)
          begin
            next unless line.include?("data")

            logger.info(line)

            payload = line.gsub(/^.*data\:/, "")
            content = JSON.parse(payload)["content"]

            Flowdock.send_message(respond_to(content), flow_token)
          rescue StandardError => ex
            logger.error(ex)
          end
        end
      end
    end
  end

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

  def self.logger
    @logger ||= Flowbot::Logger.logger
  end
end
