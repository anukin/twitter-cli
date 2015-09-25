require 'spec_helper'

module TwitterCli
  describe "Validator" do
    context "Validation" do
      it "should work for valid strings" do
        validator = Validator.new('timeline')
        expect(validator.validate).to eq(true)
      end

      it "should not work for invalid strings" do
        validator = Validator.new('foo')
        expect(validator.validate).to eq(false)
      end

      it "should work for valid strings" do
        validator = Validator.new('help')
        expect(validator.validate).to eq(true)
      end
    end
  end
end