require 'rails_helper'
#rspec spec/controllers/accounts_controller_spec.rb --format documentation

describe AccountsController do
  before :each do
    @account = FactoryGirl.create(:account)
    @activated_account = FactoryGirl.create(:account, email_confirmed: true)
  end

  describe "GET #index" do
    it "populates an array of accounts" do
      get :index, format: :json
      expect(response.status).to eq 200
      expect(Account.count).to eq(2)
      expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
      @expected = [
          @account.as_json(only: [:id, :email, :email_confirmed, :confirm_token]),
          @activated_account.as_json(only: [:id, :email, :email_confirmed, :confirm_token])
      ]
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["accounts"]).to eq(@expected)
    end
  end

  describe "POST #create" do
    context "when params[:cmd] == signup" do
      it "create account with valid params" do
        post :create, {cmd: "signup", email: "testing@gmail.com", password: "123456"} , format: :json
        @sent_email = EmailSender.send_email("testing@gmail.com",:"signup")
        expect(@sent_email).to deliver_to("testing@gmail.com")
        expect(@sent_email).to deliver_from(:user_name)
        expect(@sent_email).to have_subject("Subject - Thank You for signing up")
        expect(@sent_email).to have_body_text("Please activate your account with the code provided:\nActivation Code: #{ Account.find_by_email("testing@gmail.com").confirm_token }")
        expect(response.status).to eq 200
        expect(Account.count).to eq(3)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "success"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
      end
      it "create account with empty email" do
        post :create, {cmd: "signup", email: nil, password: "123456"} , format: :json
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "error"
        @detail_expected = "email_nil"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
        expect(parsed_body["detail"]).to eq(@detail_expected)
      end
      it "create account with empty password" do
        post :create, {cmd: "signup", email: "testing@gmail.com", password: nil} , format: :json
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "error"
        @detail_expected = "password_nil"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
        expect(parsed_body["detail"]).to eq(@detail_expected)
      end
      it "create account with email that has been activated" do
        post :create, {cmd: "signup", email: @activated_account.email, password: @activated_account.password} , format: :json
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "error"
        @detail_expected = "account_taken"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
        expect(parsed_body["detail"]).to eq(@detail_expected)
      end
      it "create account with email that has been taken but not activated" do
        post :create, {cmd: "signup", email: @account.email, password: @account.password} , format: :json
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "error"
        @detail_expected = "not_activated"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
        expect(parsed_body["detail"]).to eq(@detail_expected)
      end
    end
    context "when params[:cmd] == activate_account" do
      it "activates account with valid params" do
        post :create, {cmd: "activate_account", email: @account.email, confirm_token: @account.confirm_token} , format: :json
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "success"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
      end
      it "activates account with invalid account" do
        post :create, {cmd: "activate_account", email: !@account.email, confirm_token: @account.confirm_token} , format: :json
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "error"
        @detail_expected = "invalid_account"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
        expect(parsed_body["detail"]).to eq(@detail_expected)
      end
      it "activates account with invalid confirm_token" do
        post :create, {cmd: "activate_account", email: @account.email, confirm_token: !@account.confirm_token} , format: :json
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "error"
        @detail_expected = "wrong_token"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
        expect(parsed_body["detail"]).to eq(@detail_expected)
      end
      it "activates account that already has been activated" do
        post :create, {cmd: "activate_account", email: @activated_account.email, confirm_token: @activated_account.confirm_token} , format: :json
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "error"
        @detail_expected = "already_activated"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
        expect(parsed_body["detail"]).to eq(@detail_expected)
      end
    end
    context "when params[:cmd] == update_account" do
      it "update account with valid params" do
        post :create, {cmd: "update_account", email: @account.email, password: @account.password, confirm_token: @account.confirm_token} , format: :json
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "success"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
      end
      it "update account with invalid confirm_token" do
        post :create, {cmd: "update_account", email: @account.email, password: "123456", confirm_token: !@account.confirm_token} , format: :json
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "error"
        @detail_expected = "wrong_token"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
        expect(parsed_body["detail"]).to eq(@detail_expected)
      end
      it "update account with invalid account" do
        post :create, {cmd: "update_account", email: !@account.email, password: "123456", confirm_token: @account.confirm_token} , format: :json
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "error"
        @detail_expected = "invalid_account"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
        expect(parsed_body["detail"]).to eq(@detail_expected)
      end
    end
    context "when params[:cmd] == resend_email" do
      it "resend email with valid params" do
        post :create, {cmd: "resend_email", email: @account.email} , format: :json
        @sent_email = EmailSender.send_email(@account.email,:"signup")
        expect(@sent_email).to deliver_to(@account.email)
        expect(@sent_email).to deliver_from(:user_name)
        expect(@sent_email).to have_subject("Subject - Thank You for signing up")
        expect(@sent_email).to have_body_text("Please activate your account with the code provided:\nActivation Code: #{ Account.find_by_email(@account.email).confirm_token }")
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "success"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
      end
      it "resend email with invalid account" do
        post :create, {cmd: "resend_email", email: !@account.email} , format: :json
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "error"
        @detail_expected = "invalid_account"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
        expect(parsed_body["detail"]).to eq(@detail_expected)
      end
      it "resend email to account that has already been activated" do
        post :create, {cmd: "resend_email", email: @activated_account.email} , format: :json
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "error"
        @detail_expected = "already_activated"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
        expect(parsed_body["detail"]).to eq(@detail_expected)
      end
    end
    context "when params[:cmd] == send_password_token" do
      it "sends password token to activated account with valid params" do
        post :create, {cmd: "send_password_token", email: @activated_account.email} , format: :json
        @sent_email = EmailSender.send_email(@activated_account.email,:"reset_password")
        expect(@sent_email).to deliver_to(@activated_account.email)
        expect(@sent_email).to deliver_from(:user_name)
        expect(@sent_email).to have_subject("Subject - Password Change")
        expect(@sent_email).to have_body_text("Please change your account password with the code provided:\nCode: #{ Account.find_by_email(@activated_account.email).confirm_token }")
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "success"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
      end
      it "sends password token to unactivated account with valid params" do
        post :create, {cmd: "send_password_token", email: @account.email} , format: :json
        @sent_email = EmailSender.send_email(@account.email,:"reset_password")
        expect(@sent_email).to deliver_to(@account.email)
        expect(@sent_email).to deliver_from(:user_name)
        expect(@sent_email).to have_subject("Subject - Password Change and Account Activation")
        expect(@sent_email).to have_body_text("Please change your account password and activate your account with the code provided:\nCode: #{ Account.find_by_email(@account.email).confirm_token }")
        expect(response.status).to eq 200
        expect(Account.count).to eq(2)
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
        @msg_expected = "success"
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["msg"]).to eq(@msg_expected)
      end
      it "sends password token with invalid account" do
        post :create, {cmd: "send_password_token", email: !@account.email} , format: :json
        expect(response.status).to eq 200
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