module TwitterCli
  class UserInterface
    def initialize(username)
      @username = username
    end

    def run
      while
        @output = process(get_input)
        print_output
      end
    end

    def process(command)
      case command
      when 'help'
        help
      
      when 'exit'
        exit
      
      when 'tweet'
        msg = get_tweet
        Tweet.new(@username, msg).send_tweet

      when 'follow'
        UserFollow.new(@username, user_to_follow).follow

      when 'timeline'
        Timeline.new(@username).process

      when 'search'
        Timeline.new(get_name).process
      end
    end

    private

    def get_name
      gets.chomp
    end

    def user_to_follow
      gets.chomp
    end
    
    def get_input
      gets.chomp
    end

    def get_tweet
      gets.chomp
    end

    def print_output
      puts @output
    end

    def help
      ' __      __       .__                                
/  \    /  \ ____ |  |   ____  ____   _____   ____   
\   \/\/   _/ __ \|  | _/ ___\/  _ \ /     \_/ __ \  
 \        /\  ___/|  |_\  \__(  <_> |  Y Y  \  ___/  
  \__/\  /  \___  |____/\___  \____/|__|_|  /\___  > 
       \/       \/          \/            \/     \/  
       ' + @username + ' to TwitchBlade
            help
       tweet    : for tweeting
       follow   : for following other twitchers
       timeline : view timeline of self
       search   : view timeline of other users
       help     : for displaying help'
   end
  end
end
