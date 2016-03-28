require 'rails_helper'
#rspec spec/controllers/guild_sessions_controller_spec.rb
#zeus test spec/controllers/guild_sessions_controller_spec.rb

describe GuildSessionsController do
  before :each do
    @guild = create(:guild)
    @activated_account = @guild.guildmaster.account
    @activated_account.email_confirmed = true
    request.session[:account_id] = @activated_account.id
  end

  describe 'POST #create' do
    context "set current guild" do
      context "valid params" do
        it "updates guildmaster.current_guild_id" do
          # post :create, {guild_id: @guild.id}, {:@activated_account_id => @activated_account.id}, format: :json
          post :create, {guild_id: @guild.id}, format: :json
          expect(response.status).to eq(200)
          expect(Account.count).to eq(1)
          expect(Guild.count).to eq(1)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          expect(session[:account_id]).to_not be nil
          @msg_expected = "success"
          @guild_expected = @activated_account.guildmaster.guilds.as_json(except: [:created_at, :updated_at])
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect([parsed_body["guild"]]).to match_array(@guild_expected)
        end
      end
      context "invalid params" do
        it "empty guild_id" do
          post :create, {guild_id: nil} , format: :json
          expect(response.status).to eq(200)
          expect(Account.count).to eq(1)
          expect(Guild.count).to eq(1)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          expect(session[:account_id]).to_not be nil
          @msg_expected = "error"
          @detail_expected = "guild_id_nil"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
      end
      context "error" do
        it "wrong guild_id" do
          post :create, {guild_id: !@guild_id} , format: :json
          expect(response.status).to eq(200)
          expect(Account.count).to eq(1)
          expect(Guild.count).to eq(1)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          expect(session[:account_id]).to_not be nil
          @msg_expected = "error"
          @detail_expected = "no_such_guild_id"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
      end
    end
  end
end
