# This class controller handles the login and sign up values with appropriate references to the database
class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:create, :destroy]
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    is_admin_page = params[:is_admin_page]
    password = params[:password]
    email = params[:email]
    if email.nil?
      error_msg = 'Email entered nil'
      json_result = { msg: :error, detail: :email_nil }
    elsif password.nil?
      error_msg = 'Password entered nil'
      json_result = { msg: :error, detail: :password_nil }
    elsif !email.nil? && !password.nil?
      account = Account.find_by(email: email)
      if account.nil?
        error_msg = 'You are not an admin'
        json_result = { msg: :error, detail: :invalid_account }
      elsif !account.authenticate(password) && !account.nil?
        error_msg = 'Wrong Email or Password'
        json_result = { msg: :error, detail: :wrong_password }
        account.num_failed_attempts += 1
        if account.num_failed_attempts >= 3
          account.email_confirmed = false
          account.confirm_token = account.id * rand(999)
          error_msg = 'Account Disabled Due to too many Login attempts'
          json_result = { msg: :error, detail: :account_disabled_too_many_attempts }
        end
        account.save
      elsif !account.email_confirmed && !account.nil?
        error_msg = 'You are not an admin'
        json_result = { msg: :error, detail: :not_activated }
      elsif !account.nil? && account.authenticate(password) && account.email_confirmed
        if !account.is_admin
          session[:account_id] = account.id
          acc = Account.find(session[:account_id])
          guildmaster = acc.guildmaster
          guilds = guildmaster.guilds.as_json(except: [:created_at, :updated_at])
          error_msg = 'You are not an admin'
        elsif account.is_admin
          session[:admin_id] = account.id
          acc = Account.find(session[:admin_id])
          if is_admin_page
            flash[:success] = 'Successful login'
            redirect_to controller: 'admin/dashboard', action: 'index'
            return
          end
        end
        acc.num_failed_attempts = 0
        acc.is_logged_in = true
        acc.save
        json_result = { msg: :success, guilds: guilds }
      end
    end
    if is_admin_page.nil?
      render json: json_result.as_json
    elsif is_admin_page
      # redirect_to controller: 'admin/dashboard', action: 'new'
      flash[:error] = error_msg
      redirect_to '/'
    end
  end

  # DELETE /sessions.json
  def destroy
    unless session[:admin_id].nil?
      acc_admin = Account.find(session[:admin_id])
      acc_admin.is_logged_in = false
    end
    unless session[:account_id].nil?
      acc_player = Account.find(session[:account_id])
      acc_player.is_logged_in = false
    end
    reset_session
    result = { msg: :success }
    render json: result.as_json
  end
end
