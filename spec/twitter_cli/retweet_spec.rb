require 'spec_helper'

module TwitterCli
  describe "retweet" do
    it "should retweet the message according to the id, original author and tweet" do
      username = 'red'
      tweeted_by = 'anugrah'
      tweet_id = 15
      tweet = "retweeted anugrah : i like the smell of napalm in the morning"
      retweet = Retweet.new(username, tweeted_by, tweet_id)
      expect(retweet.execute).to eq("Successfully retweeted tweet by anugrah!")
    end
  end
end
