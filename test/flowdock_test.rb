require 'test_helper'
require 'flowdock'

describe Flowdock do
  describe ".send_message" do
    it "sends message to the flow" do
      expected_body = { "content" => "Hello world", "external_user_name" => "Flowbot" }.to_json
      stub_request(:post, /.*api\.flowdock.*/).with(body: expected_body)
      Flowdock.send_message("Hello world", "secret")
    end
  end
end
