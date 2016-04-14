require 'rails_helper'
# rspec spec/controllers/sessions_controller_spec.rb
# zeus test spec/controllers/sessions_controller_spec.rb

RSpec.describe SessionsController do
  before :each do
    @activated_account = create(:account, :activated)
    @admin_account = create(:account, :is_admin)
    @not_activated_account = create(:account)
  end

  describe 'POST #create' do
    context 'login' do
      context 'valid' do
        it 'create session for player' do
          post :create, { email: @activated_account.email, password: @activated_account.password }, format: :json
          expect(response.status).to eq(200)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          expect(session[:account_id]).to_not be nil
          @msg_expected = 'success'
          @guilds_expected = @activated_account.guildmaster.guilds.as_json(except: [:created_at, :updated_at])
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['msg']).to eq(@msg_expected)
          expect(parsed_body['guilds']).to match_array(@guilds_expected)
        end
        it 'create session for admin' do
          post :create, { email: @admin_account.email, password: @admin_account.password, is_admin_page: true }, format: :json
          expect(response.status).to eq(302)
          expect(session[:admin_id]).to_not be nil
          @flash_expected = 'Successful login'
          expect(flash[:success]).to eq(@flash_expected)
        end
      end
      context 'invalid params' do
        it 'empty email' do
          post :create, { email: nil, password: @activated_account.password }, format: :json
          expect(response.status).to eq(200)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = 'error'
          @detail_expected = 'email_nil'
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['msg']).to eq(@msg_expected)
          expect(parsed_body['detail']).to eq(@detail_expected)
        end
        it 'empty password' do
          post :create, { email: @activated_account.email, password: nil }, format: :json
          expect(response.status).to eq(200)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = 'error'
          @detail_expected = 'password_nil'
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['msg']).to eq(@msg_expected)
          expect(parsed_body['detail']).to eq(@detail_expected)
        end
      end
      context 'error' do
        it 'not_activated' do
          post :create, { email: @not_activated_account.email, password: @not_activated_account.password }, format: :json
          expect(response.status).to eq(200)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = 'error'
          @detail_expected = 'not_activated'
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['msg']).to eq(@msg_expected)
          expect(parsed_body['detail']).to eq(@detail_expected)
        end
        it 'wrong_password' do
          post :create, { email: @activated_account.email, password: !@activated_account.password }, format: :json
          expect(response.status).to eq(200)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = 'error'
          @detail_expected = 'wrong_password'
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['msg']).to eq(@msg_expected)
          expect(parsed_body['detail']).to eq(@detail_expected)
        end
        it 'wrong_password more than 3 times' do
          post :create, { email: @activated_account.email, password: !@activated_account.password }, format: :json
          post :create, { email: @activated_account.email, password: !@activated_account.password }, format: :json
          post :create, { email: @activated_account.email, password: !@activated_account.password }, format: :json
          expect(response.status).to eq(200)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = 'error'
          @detail_expected = 'account_disabled_too_many_attempts'
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['msg']).to eq(@msg_expected)
          expect(parsed_body['detail']).to eq(@detail_expected)
        end
        it 'wrong_password for admin' do
          post :create, { email: @admin_account.email, password: !@admin_account.password, is_admin_page: true }, format: :json
          expect(response.status).to eq(302)
          expect(session[:admin_id]).to be nil
          @flash_expected = 'Wrong Email or Password'
          expect(flash[:error]).to eq(@flash_expected)
        end
        it 'wrong_password more than 3 times for admin' do
          post :create, { email: @admin_account.email, password: !@admin_account.password,  is_admin_page: true }, format: :json
          post :create, { email: @admin_account.email, password: !@admin_account.password,  is_admin_page: true }, format: :json
          post :create, { email: @admin_account.email, password: !@admin_account.password,  is_admin_page: true }, format: :json
          expect(response.status).to eq(302)
          expect(session[:admin_id]).to be nil
          @flash_expected = 'Account Disabled Due to too many Login attempts'
          expect(flash[:error]).to eq(@flash_expected)
        end
        it 'invalid_account' do
          post :create, { email: !@activated_account.email, password: @activated_account.password }, format: :json
          expect(response.status).to eq(200)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = 'error'
          @detail_expected = 'invalid_account'
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['msg']).to eq(@msg_expected)
          expect(parsed_body['detail']).to eq(@detail_expected)
        end
        it 'invalid_account for admin' do
          post :create, { email: !@admin_account.email, password: @admin_account.password, is_admin_page: true }, format: :json
          expect(response.status).to eq(302)
          expect(session[:admin_id]).to be nil
          @flash_expected = 'You are not an admin'
          expect(flash[:error]).to eq(@flash_expected)
        end
      end
    end
  end
  describe 'POST #destroy' do
    it 'destroy session for player' do
      request.session[:account_id] = @activated_account.id
      post :destroy
      expect(session[:account_id]).to be nil
      expect(response.status).to eq(200)
      expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
      @msg_expected = 'success'
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['msg']).to eq(@msg_expected)
    end
    it 'destroy session for admin' do
      request.session[:admin_id] = @admin_account.id
      post :destroy
      expect(session[:admin_id]).to be nil
      expect(response.status).to eq(200)
      expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
      @msg_expected = 'success'
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['msg']).to eq(@msg_expected)
    end
  end
end
