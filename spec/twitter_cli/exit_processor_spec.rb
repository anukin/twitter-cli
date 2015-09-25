require 'spec_helper'

module TwitterCli
  describe ExitProcessor do
    conn = PG.connect(:dbname => ENV['database'])
    it "On exit should give appropriate messages" do
      exit_processor = ExitProcessor.new(conn)
      expect(exit_processor.exit_app).to eq("Good Bye!")
    end
  end
end
