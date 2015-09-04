require 'spec_helper'

module TwitterCli
  describe "user interface" do
    it "should give help to the user when asked for help" do
      username = 'anugrah'
      help = ' __      __       .__                                
/  \    /  \ ____ |  |   ____  ____   _____   ____   
\   \/\/   _/ __ \|  | _/ ___\/  _ \ /     \_/ __ \  
 \        /\  ___/|  |_\  \__(  <_> |  Y Y  \  ___/  
  \__/\  /  \___  |____/\___  \____/|__|_|  /\___  > 
       \/       \/          \/            \/     \/  
       anugrah to TwitchBlade
            help
       tweet    : for tweeting
       follow   : for following other twitchers
       unfollow : for unfollowing other twitchers
       timeline : view timeline of self
       search   : view timeline of other users
       stream   : view your stream
       retweet  : retweet
       help     : for displaying help
       logout   : for logging out'
      user_interface = UserInterface.new(username)
      expect(user_interface.process('help')).to eq(help)
    end

    it "should process if given input is tweet" do
      username = 'anugrah'
      msg = 'trolling around'
      user_interface = UserInterface.new(username)
      allow(user_interface).to receive(:get_tweet) { msg }
      timeline = Timeline.new('anugrah')
      user_interface.process('tweet')
      expect(timeline.process).to include(msg)
    end

    it "should process if given input is follow" do
      username = 'anugrah'
      user_to_follow = 'red'
      user_interface = UserInterface.new('anugrah')
      allow(user_interface).to receive(:user_to_follow) { user_to_follow }
      user_follow = UserFollow.new(username, user_to_follow)
      expect(user_interface.process('follow')).to eq(user_follow.follow)
    end

    it "should process if given input is unfollow" do
      username = 'anugrah'
      user_to_unfollow = 'red'
      user_interface = UserInterface.new('anugrah')
      allow(user_interface).to receive(:user_to_unfollow) { user_to_unfollow }
      user_unfollow = UserUnfollow.new(username, user_to_unfollow)
      expect(user_interface.process('unfollow')).to eq(user_unfollow.unfollow)
    end

    it "should process if given input is timeline" do
      username = 'anugrah'
      user_interface = UserInterface.new(username)
      expect(user_interface.process('timeline')).to eq(Timeline.new('anugrah').process)
    end

    it "should process if given input is search" do
      user_interface = UserInterface.new('anugrah')
      allow(user_interface).to receive(:get_name) { 'red' }
      expect(user_interface.process('search')).to eq(Timeline.new('red').process)
    end

    it "should process if given input is stream" do
      user_interface = UserInterface.new('anugrah')
      expect(user_interface.process('stream')).to eq(Stream.new('anugrah').get_stream)
    end

    it "should process if given input is retweet" do
      user_interface = UserInterface.new('anugrah')
      allow(user_interface).to receive(:get_tweet_id) { 4 }
      expect(user_interface.process('retweet')).to eq(Retweet.new('anugrah', 4).execute)
    end
  end
end
