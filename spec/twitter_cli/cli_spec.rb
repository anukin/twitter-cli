require 'spec_helper'

module TwitterCli
  describe "interface" do
    context "process" do
      it "should give a domain object based on input" do
        cli = Cli.new
        allow(cli).to receive(:get_name) { 'red' }
        timeline = Timeline.new('red')
        expect(cli.process("timeline")).to eq(timeline)
      end
    end

    it "should execute the processed output" do
      cli = Cli.new
      timeline = Timeline.new('red')
      expect(cli.execute(timeline)).to eq(["caught a rattata", "shine on you crazy diamond"])
    end

    it "should execute the processed output" do
      cli = Cli.new
      timeline = Timeline.new('anugrah')
      expect(cli.execute(timeline)).to eq(["hello world indeed", "shine on you crazy diamond"])
    end
  end
end
