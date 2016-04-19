# This class controller handles account creation and edition with appropriate references to the database
class AccountsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :verify_authenticity_token
  respond_to :json

  # POST /accounts.json
  # Pre-condition: all required params cannot be nil
  # password cannot be shorter than 6 characters
  # username cannot be shorter than 5 characters
  # username cannot be longer than 15 characters
  # possible cmd: signup, activate_account, update_account, resend_email, send_password_token
  #
  # ----- signup --
  # Pre-condition: email, password, username
  # sends mail, creates account in db
  # returns json format msg:success
  #
  # ----- activate_account --
  # Pre-condition: require email, confirm_token
  # updates account in db
  # returns json format msg:success
  #
  # ----- update_account --
  # Pre-condition: require email, password, confirm_token
  # updates account in db
  # returns json format msg:success
  #
  # ----- resend_email --
  # Pre-condition: require email
  # sends mail
  # returns json format msg:success
  #
  # ----- send_password_token --
  # Pre-condition: require email
  # sends mail
  # returns json format msg:success
  def create
    if params[:cmd] == 'signup'
      email = params[:email]
      password = params[:password]
      username = params[:username]
      if email.nil?
        result = { msg: :error, detail: :email_nil }
      elsif password.nil?
        result = { msg: :error, detail: :password_nil }
      elsif username.nil?
        result = { msg: :error, detail: :username_nil }
      elsif password.size < 6
        result = { msg: :error, detail: :password_too_short }
      elsif username.size < 5
        result = { msg: :error, detail: :username_too_short }
      elsif username.size > 15
        result = { msg: :error, detail: :username_too_long }
      elsif !email.nil? && !password.nil? && !username.nil?
        result = Account.create_account(email, password, username)
      end
    elsif params[:cmd] == 'activate_account'
      email = params[:email]
      confirm_token = params[:confirm_token]
      if email.nil?
        result = { msg: :error, detail: :email_nil }
      elsif confirm_token.nil?
        result = { msg: :error, detail: :confirm_token_nil }
      elsif !email.nil? && !confirm_token.nil?
        result = Account.activate_account(email, confirm_token)
      end
    elsif params[:cmd] == 'update_account'
      email = params[:email]
      password = params[:password]
      confirm_token = params[:confirm_token]
      if email.nil?
        result = { msg: :error, detail: :email_nil }
      elsif password.nil?
        result = { msg: :error, detail: :password_nil }
      elsif password.size < 6
        result = { msg: :error, detail: :password_too_short }
      elsif confirm_token.nil?
        result = { msg: :error, detail: :confirm_token_nil }
      elsif !email.nil? && !confirm_token.nil? && !password.nil?
        result = Account.update_account(email, password, confirm_token)
      end
    elsif params[:cmd] == 'resend_email'
      email = params[:email]
      if email.nil?
        result = { msg: :error, detail: :email_nil }
      elsif !email.nil?
        result = Account.resend_email(email)
      end
    elsif params[:cmd] == 'send_password_token'
      email = params[:email]
      if email.nil?
        result = { msg: :error, detail: :email_nil }
      elsif !email.nil?
        result = Account.send_password_token(email)
      end
    elsif params[:cmd].nil?
      result = { msg: :error, detail: :cmd_nil }
    else
      result = { msg: :error, detail: :no_such_cmd }
    end
    render json: result.as_json
  end
end
