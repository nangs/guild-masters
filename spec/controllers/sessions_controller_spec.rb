require 'rails_helper'
#rspec spec/controllers/sessions_controller_spec.rb
#zeus test spec/controllers/sessions_controller_spec.rb

RSpec.describe SessionsController do
  before :each do
    @activated_account = create(:account, :activated)
    @not_activated_account = create(:account)
  end

  describe 'POST #create' do
    context "login" do
      context "valid" do
        it "create session" do
          post :create, {email: @activated_account.email, password: @activated_account.password} , format: :json
          expect(response.status).to eq(200)
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          expect(session[:account_id]).to_not be nil
          @msg_expected = "success"
          @guilds_expected = @activated_account.guildmaster.guilds.as_json(except: [:created_at, :updated_at])
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["guilds"]).to match_array(@guilds_expected)
        end
      end
      context "invalid params" do
        it "empty email" do
          post :create, {email: nil, password: @activated_account.password} , format: :json
          expect(response.status).to eq(200)
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "email_nil"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
        it "empty password" do
          post :create, {email: @activated_account.email, password: nil} , format: :json
          expect(response.status).to eq(200)
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "password_nil"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
      end
      context "error" do
        it "not_activated" do
          post :create, {email: @not_activated_account.email, password: @not_activated_account.password} , format: :json
          expect(response.status).to eq(200)
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "not_activated"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
        it "wrong_password" do
          post :create, {email: @activated_account.email, password: !@activated_account.password} , format: :json
          expect(response.status).to eq(200)
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "wrong_password"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
        it "invalid_account" do
          post :create, {email: !@activated_account.email, password: @activated_account.password} , format: :json
          expect(response.status).to eq(200)
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "invalid_account"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
      end
    end
  end
  describe 'POST #destroy' do
    it "destroy session" do
      post :destroy
      expect(session[:account_id]).to be nil
      expect(response.status).to eq(200)
      expect(Account.count).to eq(2)
      expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
      @msg_expected = "success"
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["msg"]).to eq(@msg_expected)
    end
  end
end
