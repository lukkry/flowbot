require 'test_helper'
require 'flowbot'

describe Flowbot do
  describe ".respond_to" do
    it "responds with the url to a meme" do
      msg = '@f meme yuno "y u no" "enjoy ur life?!"'
      meme_url = "http://v1.memecaptain.com/c17c65.jpg"
      MemeMatcher.expects(:match).with('yuno "y u no" "enjoy ur life?!"').returns(meme_url)
      assert_equal meme_url, Flowbot.respond_to(msg)
    end
  end
end
