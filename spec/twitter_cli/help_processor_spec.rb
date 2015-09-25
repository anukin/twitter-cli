require 'spec_helper'

module TwitterCli
  describe HelpProcessor do
    conn = PG.connect(:dbname => ENV['database'])
    context "help" do
      it "should display help when user demands for it" do
        help_processor = HelpProcessor.new(conn)
        help = '
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
        expect(help_processor.help).to eq(help)
      end
    end
  end
end
