require 'rails_helper'
# rspec spec/controllers/sessions_controller_spec.rb

describe SessionsController do
  before :each do
    @guild = create(:guild)
    @guild2 = create(:guild)
    @account = @guild.guildmaster.account
    @activated_account = @guild2.guildmaster.account
    @activated_account.email_confirmed = true
    session[:@activated_account]=@activated_account.id
  end

  describe 'POST #create' do
    context "login" do
      context "valid" do
        it "create session" do
          post :create, {email: @activated_account.email, password: @activated_account.password} , format: :json
          expect(response.status).to eq(200)
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "success"
          @guilds_expected = @activated_account.guildmaster.guilds.as_json(except: [:created_at, :updated_at])
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["guilds"]).to match_array(@guilds_expected)
        end
      end

    end
  end
end