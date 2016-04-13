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
      flash[:error] = 'Email entered nil'
      json_result = { msg: :error, detail: :email_nil }
    elsif password.nil?
      flash[:error] = 'Password entered nil'
      json_result = { msg: :error, detail: :password_nil }
    elsif !email.nil? && !password.nil?
      account = Account.find_by(email: email)
      if account.nil?
        flash[:error] = 'You are not an admin'
        json_result = { msg: :error, detail: :invalid_account }
      elsif !account.authenticate(password) && !account.nil?
        flash[:error] = 'Wrong Email or Password'
        json_result = { msg: :error, detail: :wrong_password }
      elsif !account.email_confirmed && !account.nil?
        flash[:error] = 'You are not an admin'
        json_result = { msg: :error, detail: :not_activated }
      elsif !account.nil? && account.authenticate(password) && account.email_confirmed
        if !account.is_admin
          session[:account_id] = account.id
          acc = Account.find(session[:account_id])
          guildmaster = acc.guildmaster
          guilds = guildmaster.guilds.as_json(except: [:created_at, :updated_at])
          flash[:error] = 'You are not an admin'
        elsif account.is_admin
          session[:admin_id] = account.id
          flash[:success] = 'Successful login'
          if is_admin_page
            redirect_to controller: 'admin/dashboard', action: 'index'
            return
          end
        end
        json_result = { msg: :success, guilds: guilds }
      end
    end
    if is_admin_page.nil?
      render json: json_result.as_json
    elsif is_admin_page
      # redirect_to controller: 'admin/dashboard', action: 'new'
      redirect_to '/'
    end
  end

  # DELETE /sessions.json
  def destroy
    reset_session
    result = { msg: :success }
    render json: result.as_json
  end
end
