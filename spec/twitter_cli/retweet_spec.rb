require 'spec_helper'

module TwitterCli
  describe "retweet" do
    it "the retweeted message must be a part of user's timeline" do
      username = 'red'
      tweeted_by = 'anugrah'
      tweet_id = 15
      tweet = "anugrah : i like the smell of napalm in the morning"
      retweet = Retweet.new(username, tweeted_by, tweet_id)
      retweet.execute
      expect(Timeline.new('red').process).to include(tweet)
    end

    it "should allow retweet over retweet in such a way that the original author is only mentioned" do
      username = 'red'
      tweeted_by = 'anugrah'
      tweet_id = 15
      tweet = "anugrah : i like the smell of napalm in the morning"
      retweet = Retweet.new(username, tweeted_by, tweet_id)
      expect(retweet.execute).to eq("You have already retweeted this tweet")
    end
  end
end
