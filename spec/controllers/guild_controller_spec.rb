require 'rails_helper'
#rspec spec/controllers/guild_controller_spec.rb
#zeus test spec/controllers/guild_controller_spec.rb

RSpec.describe GuildController do
  before :each do
    @guild = create(:guild)
    @activated_account = @guild.guildmaster.account
    @activated_account.email_confirmed = true
  end

  describe 'POST #create' do
    context "valid session" do
      it "builds guild" do
        request.session[:account_id] = @activated_account.id
        post :create
        expect(response.status).to eq(200)
        expect(Account.count).to eq(1)
        expect(Guild.count).to eq(2)
        @msg_expected = "success"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
      end
    end
    context "invalid session" do
      it "renders 401" do
        post :create
        expect(response.status).to eq(401)
      end
    end
  end
end
