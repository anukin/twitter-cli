module TwitterCli
  class ExitProcessor < Processor
    def execute
      @conn.close
      puts exit_app
      exit
    end

    def exit_app
      "Good Bye!"
    end
  end
end
