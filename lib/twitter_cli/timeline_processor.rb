module TwitterCli
  class TimelineProcessor < Processor
    def execute
      Timeline.new(@conn, get_name).process
    end

    private

    def get_name
      puts "Please enter the name for accessing timeline ?"
      gets.chomp
    end
  end
end
