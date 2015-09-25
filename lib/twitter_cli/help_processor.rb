module TwitterCli
  class HelpProcessor < Processor
    def execute
      '
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
    end
  end
end