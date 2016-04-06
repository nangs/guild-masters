require 'rails_helper'
#rspec spec/controllers/quests_controller_spec.rb
#zeus test spec/controllers/quests_controller_spec.rb

RSpec.describe QuestsController do
  before :each do
    @activated_account = create(:account, :activated)
    @guildmaster = @activated_account.guildmaster
    @guild = Guild.find_by(guildmaster_id: @guildmaster.id)
    @guildmaster.current_guild_id = @guild.id
    @guildmaster.save
  end
  describe 'POST #create' do
    context "valid session" do
      context "when params[:cmd] == get" do
        it "get quests" do
          request.session[:account_id] = @activated_account.id
          post :create, {cmd: "get"} , format: :json
          expect(response.status).to eq(200)
          expect(Account.count).to eq(1)
          expect(Guild.count).to eq(1)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          expect(session[:account_id]).to_not be nil
          @msg_expected = "success"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["quests"]).to_not be nil
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
