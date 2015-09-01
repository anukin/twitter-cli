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
       tweet : for tweeting
       help  : for displaying help'
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
  end
end
