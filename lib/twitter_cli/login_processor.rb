require 'io/console'

module TwitterCli
  class LoginProcessor < Processor
    attr_accessor :user_interface
    
    def initialize(conn)
      super(conn)
      @rejected_values = ["Access denied! No user by that name.", "Access denied! Check your password."]
    end

    def execute
      name = get_name
      user_login = UserLogin.new(@conn, name, get_password)
      result = user_login.process
      unless @rejected_values.include? result
        @user_interface ||= UserInterface.new(name)
        puts user_interface.help
        puts "Dear " + name + " your tweets are \n"
        puts result
        @user_interface.run
      else
        result
      end
    end

    private

    def get_name
      puts "Pls enter the name which you wish to login with ?"
      gets.chomp
    end

    def get_password
      puts "Pls enter the password ?\n"
      STDIN.noecho(&:gets).chomp
    end
  end
end
