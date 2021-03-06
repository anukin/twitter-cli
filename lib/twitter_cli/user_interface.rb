module TwitterCli
  class UserInterface
    def initialize(username)
      @username = username
    end

    def run
      while
        @output = process(get_input)
        break if @output == "logging out"
        print_output
      end
      @output
    end

    def process(command)
      connect
      #need to pull out the branch on condition
      #Can do this by pulling out common behaviour ie conn and username into different class and then asking for more infor part of class ?
      case command
      when 'help'
        help
      
      when 'tweet'
        msg = get_tweet
        Tweet.new(@conn, @username, msg).send_tweet

      when 'follow'
        UserFollow.new(@conn, @username, user_to_follow).follow

      when 'timeline'
        puts "You are viewing your timeline now\n"
        Timeline.new(@conn, @username).process

      when 'search'
        Timeline.new(@conn, get_name).process

      when 'stream'
        Stream.new(@conn, @username).get_stream

      when 'retweet'
        #retweet verification need to be here
        Retweet.new(@conn, @username, get_tweet_id).execute

      when 'unfollow'
        UserUnfollow.new(@conn, @username, user_to_unfollow).unfollow

      when 'logout'
        disconnect
        "logging out"

      else
        "Not a valid input!"
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
       retweet  : retweet
       help     : for displaying help
       logout   : for logging out'
    end

    private

    def get_tweet_id
      puts "Pls enter the tweet id you wish to retweet"
      gets.chomp.to_i
    end

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

    def connect
      begin
        @conn = PG.connect(:hostaddr => ENV['hostaddress'], :dbname => ENV['database'], :port => ENV['port'], :user => ENV['username'], :password => ENV['password'])
      rescue
        puts "sorry but network seems to be down pls try again!"
        exit
      end
    end

    def disconnect
      @conn.close
    end
  end
end
