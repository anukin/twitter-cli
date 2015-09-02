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
       timeline : view timeline of self
       search   : view timeline of other users
       help     : for displaying help'
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
  end
end
