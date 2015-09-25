require 'spec_helper'

module TwitterCli
  describe LoginProcessor do
    conn = PG.connect(:dbname => ENV['database'])
    describe '#execute' do
      context 'when user wants to logout' do
        it "should handle the login of valid user" do
          conn.exec('begin')
          login_processor = LoginProcessor.new(conn)
          allow(login_processor).to receive(:get_name) { 'anugrah' }
          allow(login_processor).to receive(:get_password) { 'megamind' }
          user_interface = UserInterface.new('anugrah')
          allow(user_interface).to receive(:get_input).and_return('logout')
          login_processor.user_interface = user_interface
          expect(login_processor.execute).to eq("logging out")
        end
      end
    end
  end
end
