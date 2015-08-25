require 'spec_helper'

module TwitterCli
  describe "interface" do
    it "should give access to timeline if asked for timeline" do
      cli = double("cli")
      expect(cli).to receive(:parse) {'timeline'}
      expect(cli.take_input).to eq('timeline')
    end
  end
end
