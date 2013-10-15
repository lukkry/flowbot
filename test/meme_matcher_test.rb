require 'test_helper'
require 'meme_matcher'

describe MemeMatcher do
  describe ".match" do
    let(:meme_url){ "http://v1.memecaptain.com/c17c65.jpg" }

    it "responds with the url to a meme when both texts are present" do
      msg = 'yuno "y u no" "enjoy ur life?!"'
      MemeGenerator.expects(:url).with("yuno", "y u no", "enjoy ur life?!").returns(meme_url)

      assert_equal meme_url, MemeMatcher.match(msg)
    end

    it "responds with the url to a meme when only an upper text is present" do
      msg = 'yuno "y u no"'
      MemeGenerator.expects(:url).with("yuno", "y u no", nil).returns(meme_url)

      assert_equal meme_url, MemeMatcher.match(msg)
    end

    it "returns a blank string when meme type is blank" do
      msg = '"y u no" "enjoy ur life?!"'
      refute MemeMatcher.match(msg)
    end
  end
end
