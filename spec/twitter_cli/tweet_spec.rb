require 'spec_helper'

  module TwitterCli
  describe "tweet" do
    it "should be possible for the user to tweet" do
      username = 'anugrah'
      msg = 'i like the smell of napalm in the morning'
      tweet = Tweet.new(username,msg)
      tweet.send_tweet
      timeline = Timeline.new(username)
      expect(timeline.process).to include(msg)
    end
  end
end
