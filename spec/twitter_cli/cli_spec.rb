require 'spec_helper'

module TwitterCli
  describe "interface" do
    context "process" do
      it "should process based on input and output" do
        cli = Cli.new
        allow(cli).to receive(:get_name_timeline) { 'red' }
        timeline = Timeline.new('red')
        tweets_of_red = ["caught a rattata", "shine on you crazy diamond"]
        expect(cli.process("timeline")).to eq(tweets_of_red)
      end
      
      it "should process based on input and output when input is help" do
        cli = Cli.new
        help_menu = " ___                                                                       
-   ---___-             ,       ,,          _-_ _,,   ,,        |\         
   (' ||    ;       '  ||       ||             -/  )  ||   _     \\        
  ((  ||    \\/\/\ \\ =||=  _-_ ||/\\         ~||_<   ||  < \,  / \\  _-_  
 ((   ||    || | | ||  ||  ||   || ||          || \\  ||  /-|| || || || \\ 
  (( //     || | | ||  ||  ||   || ||          ,/--|| || (( || || || ||/   
    -____-  \\/\\/ \\  \\, \\,/ \\ |/         _--_-'  \\  \/\\  \\/  \\,/  
                                  _/         (                             " + 
                                 "\nAvailable Commands are" + 
                                 "\ntimeline : for accessing timeline" +
                                 "\nregister : to register for twitchblade" +  
                                 "\nhelp : for help" + 
                                 "\nexit : for exit\n"
        expect(cli.process("help")).to eq(help_menu)
      end

      it "should process based on input and output when input is register" do
        cli = Cli.new
        allow(cli).to receive(:get_name) { 'lol' }
        allow(cli).to receive(:get_password) { 'lol'}
        timeline = Timeline.new('lol')
        expect(cli.process("register")).to eq(timeline.process)
      end
    end
  end
end
