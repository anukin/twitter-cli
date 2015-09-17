require 'spec_helper'

module TwitterCli
  describe "user interface" do
    let(:conn) { PG.connect(:dbname => ENV['database']) }
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
      conn.exec('begin')
      username = 'anugrah'
      msg = 'trolling around'
      user_interface = UserInterface.new(username)
      allow(user_interface).to receive(:get_tweet) { msg }
      timeline = Timeline.new(conn, 'anugrah')
      expect(user_interface.process('tweet')).to eq("Successfully tweeted")
      conn.exec('rollback')
    end

    it "should process if given input is retweet" do
      conn.exec('begin')
      user_interface = UserInterface.new('anugrah')
      allow(user_interface).to receive(:get_tweet_id) { 4 }
      expect(user_interface.process('retweet')).to eq(Retweet.new(conn, 'anugrah', 4).execute)
      conn.exec('rollback')
    end

    it "should return appropriate error message if input doesnot match expectations" do
      user_interface = UserInterface.new('anugrah')
      expect(user_interface.process('foo')).to eq("Not a valid input!")
    end
  end
end
