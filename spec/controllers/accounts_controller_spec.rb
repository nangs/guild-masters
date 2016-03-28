require 'rails_helper'
require 'thread'
$semaphore = Mutex.new
#rspec spec/controllers/accounts_controller_spec.rb

describe AccountsController do
  before :each do
    @account = create(:account)
    @activated_account = create(:account, email_confirmed: true)
  end

  # describe "GET #index" do
  #   it "populates an array of accounts" do
  #     get :index, format: :json
  #     expect(response.status).to eq 200
  #     expect(Account.count).to eq(2)
  #     expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
  #     @expected = [
  #         @activated_account.as_json(only: [:id, :email, :email_confirmed, :confirm_token]),
  #         @account.as_json(only: [:id, :email, :email_confirmed, :confirm_token])
  #     ]
  #     parsed_body = JSON.parse(response.body)
  #     expect(parsed_body["accounts"]).to match_array(@expected)
  #   end
  # end

  describe "POST #create" do
    context "when params[:cmd] == signup" do
      context "valid" do
        it "create account and sends email" do
          post :create, {cmd: "signup", email: "testing@gmail.com", password: "123456"} , format: :json
          thr = Thread.new {
            $semaphore.synchronize {
              @sent_email = EmailSender.send_email("testing@gmail.com",:"signup")
              expect(@sent_email).to deliver_to("testing@gmail.com")
              expect(@sent_email).to deliver_from(:user_name)
              expect(@sent_email).to have_subject("Subject - Thank You for signing up")
              expect(@sent_email).to have_body_text("Please activate your account with the code provided:\nActivation Code: #{ Account.find_by_email("testing@gmail.com").confirm_token }")
            }
          }
          thr.join(0)
          expect(response.status).to eq 200
          expect(Account.count).to eq(3)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "success"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
        end
      end
      context "invalid" do
        it "password less than 6 characters" do
          post :create, {cmd: "signup", email: "testing@gmail.com", password: "12345"} , format: :json
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "password_too_short"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
        it "empty email" do
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
        it "empty password" do
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
      end
      context "error" do
        it "account has been activated" do
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
        it "account has been taken but not activated" do
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
    end
    context "when params[:cmd] == activate_account" do
      context "valid" do
        it "activates account" do
          post :create, {cmd: "activate_account", email: @account.email, confirm_token: @account.confirm_token} , format: :json
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "success"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
        end
      end
      context "invalid params" do
        it "empty email" do
          post :create, {cmd: "activate_account", email: nil, confirm_token: @account.confirm_token} , format: :json
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "email_nil"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
        it "empty confirm_token" do
          post :create, {cmd: "activate_account", email: @account.email, confirm_token: nil} , format: :json
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "confirm_token_nil"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
      end
      context "error" do
        it "account already has been activated" do
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
        it "invalid account" do
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
        it "wrong confirm_token" do
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
      end
    end
    context "when params[:cmd] == update_account" do
      context "valid" do
        it "update account" do
          post :create, {cmd: "update_account", email: @account.email, password: @account.password, confirm_token: @account.confirm_token} , format: :json
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "success"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
        end
      end
      context "invalid params" do
        it "empty confirm_token" do
          post :create, {cmd: "update_account", email: @account.email, password: nil, confirm_token: @account.confirm_token} , format: :json
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "password_nil"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
        it "empty email" do
          post :create, {cmd: "update_account", email: nil, password: "123456", confirm_token: @account.confirm_token} , format: :json
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "email_nil"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
        it "empty confirm_token" do
          post :create, {cmd: "update_account", email: @account.email, password: "123456", confirm_token: nil} , format: :json
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "confirm_token_nil"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
        it "password less than 6 characters" do
          post :create, {cmd: "update_account", email: @account.email, password: "12345", confirm_token: @account.confirm_token} , format: :json
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "password_too_short"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
      end
      context "error" do
        it "wrong confirm_token" do
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
        it "invalid account" do
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
    end
    context "when params[:cmd] == resend_email" do
      context "valid" do
        it "resend email" do
          post :create, {cmd: "resend_email", email: @account.email} , format: :json
          thr = Thread.new {
            $semaphore.synchronize {
              @sent_email = EmailSender.send_email(@account.email,:"signup")
              expect(@sent_email).to deliver_to(@account.email)
              expect(@sent_email).to deliver_from(:user_name)
              expect(@sent_email).to have_subject("Subject - Thank You for signing up")
              expect(@sent_email).to have_body_text("Please activate your account with the code provided:\nActivation Code: #{ Account.find_by_email(@account.email).confirm_token }")
            }
          }
          thr.join(0)
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "success"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
        end
      end
      context "invalid params" do
        it "empty email" do
          post :create, {cmd: "resend_email", email: nil} , format: :json
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "email_nil"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
      end
      context "error" do
        it "account has already been activated" do
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
        it "invalid account" do
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
      end
    end
    context "when params[:cmd] == send_password_token" do
      context "valid" do
        it "sends password token by email to activated account" do
          post :create, {cmd: "send_password_token", email: @activated_account.email} , format: :json
          thr = Thread.new {
            $semaphore.synchronize {
              @sent_email = EmailSender.send_email(@activated_account.email,:"reset_password")
              expect(@sent_email).to deliver_to(@activated_account.email)
              expect(@sent_email).to deliver_from(:user_name)
              expect(@sent_email).to have_subject("Subject - Password Change")
              expect(@sent_email).to have_body_text("Please change your account password with the code provided:\nCode: #{ Account.find_by_email(@activated_account.email).confirm_token }")
            }
          }
          thr.join(0)
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "success"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
        end
        it "sends password token by email to unactivated account" do
          post :create, {cmd: "send_password_token", email: @account.email} , format: :json
          thr = Thread.new {
            $semaphore.synchronize {
              @sent_email = EmailSender.send_email(@account.email,:"reset_password")
              expect(@sent_email).to deliver_to(@account.email)
              expect(@sent_email).to deliver_from(:user_name)
              expect(@sent_email).to have_subject("Subject - Password Change and Account Activation")
              expect(@sent_email).to have_body_text("Please change your account password and activate your account with the code provided:\nCode: #{ Account.find_by_email(@account.email).confirm_token }")
            }
          }
          thr.join(0)
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "success"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
        end
      end
      context "invalid params" do
        it "empty email" do
          post :create, {cmd: "send_password_token", email: nil} , format: :json
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
          expect(ActiveSupport::JSON.decode(response.body)).not_to be_nil
          @msg_expected = "error"
          @detail_expected = "email_nil"
          parsed_body = JSON.parse(response.body)
          expect(parsed_body["msg"]).to eq(@msg_expected)
          expect(parsed_body["detail"]).to eq(@detail_expected)
        end
      end
      context "error" do
        it "invalid account" do
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
    context "when params[:cmd] == nil or not valid" do
      context "invalid params" do
        it "empty cmd" do
          post :create, {cmd: nil} , format: :json
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
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
          post :create, {cmd: "not_valid_cmd"}, format: :json
          expect(response.status).to eq 200
          expect(Account.count).to eq(2)
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
end