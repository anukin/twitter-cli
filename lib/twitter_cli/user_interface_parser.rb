module TwitterCli
  class UserInterfaceParser
    def initialize(username, command)
      @username = username
      @command = command
    end
    
    def parse
      case @command
      when 'help'
        help
      when 'tweet'
        create_tweet(get_tweet)
      end
    end

    private
    def get_tweet
      gets.chomp
    end

    def create_tweet(msg)
      Tweet.new(@username, msg)
    end
    
    def help
      ' __      __       .__                                
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
     end
   end
 end
