module TwitterCli
  class UserInterface
    def initialize(username)
      @username = username
    end

    def run
      while
        @output = process(get_input)
        if @output == "logging out"
          break
        end
        print_output
      end
      @output
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
        puts "You are viewing your timeline now\n"
        Timeline.new(@username).process

      when 'search'
        Timeline.new(get_name).process

      when 'stream'
        Stream.new(@username).get_stream

      when 'unfollow'
        UserUnfollow.new(@username, user_to_unfollow).unfollow

      when 'logout'
        "logging out"
      end
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
       unfollow : for unfollowing other twitchers
       timeline : view timeline of self
       search   : view timeline of other users
       stream   : view your stream
       help     : for displaying help
       logout   : for logging out'
   end

    private

    def get_name
      puts "Pls enter the name to search for ? \n"
      gets.chomp
    end

    def user_to_follow
      puts "Pls enter the name to follow ? \n"
      gets.chomp
    end

    def user_to_unfollow
      puts "Pls enter the name to unfollow ? \n"
      gets.chomp
    end
    
    def get_input
      puts "Pls enter the choice"
      gets.chomp
    end

    def get_tweet
      puts "Pls give the tweet you wish to make ?"
      gets.chomp
    end

    def print_output
      puts @output
    end
  end
end
