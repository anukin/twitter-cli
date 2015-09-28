module TwitterCli
  class Processor
    def initialize(connection)
      @conn = connection
    end

    def execute
      raise NotImplementedError, "This #{self.class} can not respond to:"
    end
  end
end
