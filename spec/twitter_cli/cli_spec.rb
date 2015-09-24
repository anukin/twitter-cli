require 'spec_helper'

module TwitterCli
  describe "interface" do
    let(:conn) { PG.connect(:dbname => ENV['database']) }
    let(:res_red) { conn.exec('select id, username, tweet from tweets where username = $1', ['red']) }
    let(:res_anugrah) { conn.exec('select id, username, tweet from tweets where username = $1', ['anugrah']) }
    let(:tweets) { [] }
    def helper_get_tweets(res)
      res.each do|row|
        tweets << ( row['id'] + " " + row['username'] + " : " + row['tweet'] ) 
      end
      tweets
    end
    context "process" do
      it "should process based on input and output" do

        cli = Cli.new
        allow(cli).to receive(:get_name_timeline) { 'red' }

        tweets_of_red = helper_get_tweets(res_red)
        expect(cli.process("timeline")).to eq(tweets_of_red)
      end
      
      it "should process based on input and output when input is help" do
        cli = Cli.new
        help_menu = '
 ______       _ __      __     ___  __        __   
/_  __/    __(_) /_____/ /    / _ )/ /__ ____/ /__ 
 / / | |/|/ / / __/ __/ _ \  / _  / / _ `/ _  / -_)
/_/  |__,__/_/\__/\__/_//_/ /____/_/\_,_/\_,_/\__/ 
                                                    ' + 
                                 "\nAvailable Commands are" + 
                                 "\ntimeline : for accessing timeline" +
                                 "\nregister : to register for twitchblade" +
                                 "\nlogin : login to twitchblade" +
                                 "\nhelp : for help" + 
                                 "\nexit : for exit\n"
        expect(cli.process("help")).to eq(help_menu)
      end

      # it "should process based on input and output when input is register" do
      #   cli = Cli.new
      #   allow(cli).to receive(:get_name) { 'lol' }
      #   allow(cli).to receive(:get_password) { 'lol'}
      #   timeline = Timeline.new('lol')
      #   expect(cli.process("register")).to eq(timeline.process)
      # end

      # it "should process based on input and output when input is login" do
      #   cli = Cli.new
      #   allow(cli).to receive(:get_name) { 'anugrah' }
      #   allow(cli).to receive(:get_password) { 'megamind' }
      #   timeline = Timeline.new('anugrah')
      #   expect(cli.process("login")).to eq(timeline.process)
      # end
      it "should handle the case where the user enters anything other than what is given" do
        cli = Cli.new
        message = "Not a valid command pls type help for use"
        expect(cli.process('foo')).to eq(message)
      end
    end
  end
end
