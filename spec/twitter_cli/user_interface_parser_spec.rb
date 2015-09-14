require 'spec_helper'

module TwitterCli
  describe "user interface" do
    let (:username) { 'anugrah' }
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
      user_interface_parser = UserInterfaceParser.new(username, 'help')
      expect(user_interface_parser.parse).to eq(help)
    end


    it "should process if given input is tweet" do
      msg = 'trolling around'
      parser = UserInterfaceParser.new(username, 'tweet')
      allow(parser).to receive(:get_tweet) { msg }
      tweet = Tweet.new(username, msg)
      expect(parser.parse).to eq(tweet)
    end
  end
end