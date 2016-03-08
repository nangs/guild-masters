class AccountsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create, :index]
  skip_before_action :verify_authenticity_token
  respond_to :json

#############################################################################
########for testing not for release
########
# GET /accounts.json
  def index
    accounts = Account.all
    render json: accounts.as_json(only: [:id, :email, :email_confirmed, :confirm_token])
  end
########
########for testing not for release
#############################################################################


# POST /accounts.json
#When a POST is done with parameters email and password, this function will check with if the post is a signup or login
#it will then redirect to the respective function in the model
#it then returns a json format of what the model returns
  def create
    if params[:cmd] == "signup"
      email = params[:email]
      password = params[:password]
      result = Account.create_account(email,password)
      render json: result
      thr = Thread.new { Account.send_email(email,:"signup") }
      thr.join(0)
    elsif params[:cmd] == "activate_account"
      email = params[:email]
      confirm_token = params[:confirm_token]
      result = Account.activate_account(email,confirm_token)
      render json: result
    elsif params[:cmd] == "update_account"
      email = params[:email]
      password = params[:password]
      confirm_token = params[:confirm_token]
      result = Account.update_account(email,password,confirm_token)
      render json: result
    elsif params[:cmd] == "resend_email"
      email = params[:email]
      result = Account.resend_email(email)
      render json: result
      thr = Thread.new { Account.send_email(email,:"signup") }
      thr.join(0)
    elsif params[:cmd] == "send_password_token"
      email = params[:email]
      result = Account.send_password_token(email)
      render json: result
      thr = Thread.new { Account.send_email(email,:"reset_password") }
      thr.join(0)
    end
  end
end