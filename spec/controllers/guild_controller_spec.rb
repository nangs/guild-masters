require 'rails_helper'
#rspec spec/controllers/guild_controller_spec.rb
#zeus test spec/controllers/guild_controller_spec.rb

RSpec.describe GuildController do
  before :each do
    @guild = create(:guild)
    @guildmaster = @guild.guildmaster
    @guildmaster.current_guild_id = @guild.id
    @activated_account = @guild.guildmaster.account
    @activated_account.email_confirmed = true
  end
  describe 'POST #create' do
    context "valid session" do
      context "when params[:cmd] == get" do
        it "gets guild" do
          request.session[:account_id] = @activated_account.id
          post :create, {cmd: "get"} , format: :json
          expect(response.status).to eq(200)
          expect(Account.count).to eq(1)
          expect(Guild.count).to eq(1)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          expect(session[:account_id]).to_not be nil
          @msg_expected = "success"
          @guild_expected = {level: @guild.level,
          popularity: @guild.popularity,
              pop_requirement: 100*(2**(@guild.level-1)),
              gold_requirement: 2000*(@guild.level+1),
              number_adventurer:@guild.adv_count,
              number_quest:@guild.qst_count,
              adventurer_capacity: @guild.level*5,
              quest_capacity: @guild.level*10,
              is_upgradable: @guild.is_upgradable,
              is_full: @guild.is_full}
          parsed_body = JSON.parse(response.body)
          # expect(parsed_body["detail"]).to eq(@msg_expected)
          # expect(parsed_body["guild"]).to eq(@guild_expected)
        end
      end
      context "when params[:cmd] == create" do
        it "builds guild" do
          request.session[:account_id] = @activated_account.id
          post :create, {cmd: "create"} , format: :json
          expect(response.status).to eq(200)
          expect(Account.count).to eq(1)
          expect(Guild.count).to eq(2)
          @msg_expected = "success"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
        end
      end
      context "when params[:cmd] == nil or not valid" do
        context "invalid params" do
          it "empty cmd" do
            request.session[:account_id] = @activated_account.id
            post :create, {cmd: nil} , format: :json
            expect(response.status).to eq 200
            expect(Account.count).to eq(1)
            expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
            @msg_expected = "error"
            @detail_expected = "cmd_nil"
            parsed_body = JSON.parse(response.body)
            expect(parsed_body["msg"]).to eq(@msg_expected)
            expect(parsed_body["detail"]).to eq(@detail_expected)
          end
        end
        context "error" do
          it "invalid cmd" do
            request.session[:account_id] = @activated_account.id
            post :create, {cmd: "not_valid_cmd"}, format: :json
            expect(response.status).to eq 200
            expect(Account.count).to eq(1)
            expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
            @msg_expected = "error"
            @detail_expected = "no_such_cmd"
            parsed_body = JSON.parse(response.body)
            expect(parsed_body["msg"]).to eq(@msg_expected)
            expect(parsed_body["detail"]).to eq(@detail_expected)
          end
        end
      end
    end
    context "invalid session" do
      it "renders 401" do
        post :create, {cmd: "create"}
        expect(response.status).to eq(401)
      end
    end
  end
end
