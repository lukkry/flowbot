require 'test_helper'
require 'meme_generator'

describe MemeGenerator do
  describe ".url" do
    before do
      @response = {
        "imageUrl" => "http://v1.memecaptain.com/c17c65.jpg",
        "templateUrl" => "http://v1.memecaptain.com/?u=c17c65.jpg"
      }
    end

    it "generates an url" do
      stub_request(:get, /.*memecaptain.*/).to_return(body: @response.to_json, status: 200)
      url = MemeGenerator.url("yuno", "y u no", "enjoy ur life?!")
      assert "http://v1.memecaptain.com/c17c65.jpg", url
    end
  end
end
