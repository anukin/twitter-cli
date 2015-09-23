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

    it "should process if given input is follow" do
      user_interface = UserInterface.new('anugrah')
      allow(user_interface).to receive(:user_to_follow) { 'red' }
      expect(user_interface.process('follow')).to eq("Successfully followed red")
    end

    it "should process if given input is unfollow" do
      user_interface = UserInterface.new('anugrah')
      allow(user_interface).to receive(:user_to_unfollow) { 'red' }
      expect(user_interface.process('unfollow')).to eq("Successfully unfollowed red")
    end

    it "should process if given input is timeline" do
      conn.exec('begin')
      user_interface = UserInterface.new('anugrah')
      expect(user_interface.process('timeline')).to eq(Timeline.new(conn, 'anugrah').process)
      conn.exec('rollback')
    end

    it "should process if given input is search" do
      conn.exec('begin')
      user_interface = UserInterface.new('anugrah')
      allow(user_interface).to receive(:get_name) { 'red' }
      expect(user_interface.process('search')).to eq(Timeline.new(conn, 'red').process)
      conn.exec('rollback')
    end

    it "should process if given input is timeline" do
      conn.exec('begin')
      user_interface = UserInterface.new('anugrah')
      expect(user_interface.process('stream')).to eq(Stream.new(conn, 'anugrah').get_stream)
      conn.exec('rollback')
    end

    it "should return appropriate error message if input doesnot match expectations" do
      user_interface = UserInterface.new('anugrah')
      expect(user_interface.process('foo')).to eq("Not a valid input!")
    end

    it "should return appropriate error message if input doesnot match expectations" do
      user_interface = UserInterface.new('anugrah')
      expect(user_interface.process('logout')).to eq("logging out")
    end
  end
end
