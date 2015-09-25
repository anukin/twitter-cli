module TwitterCli
  class RegisterProcessor < Processor
    attr_accessor :user_interface
    
    def initialize(conn)
      super(conn)
      @rejected_values = ["Another user exists with same name pls go for some other username!"]
    end

    def execute
      name = get_name
      user_register = UserRegistration.new(@conn, name, get_password)
      result = user_register.process
      unless @rejected_values.include? result
        @user_interface ||= UserInterface.new(name)
        puts "Dear " + name + " Please tweet or follow users your stream is currently empty\n"
        puts user_interface.help
        puts result
        @user_interface.run
      else
        result
      end
    end

    private

    def get_name
      puts "Pls enter the name which you wish to register with ?"
      gets.chomp
    end

    def get_password
      puts "Pls enter the password for your account?\n"
      STDIN.noecho(&:gets).chomp
    end
  end
end
