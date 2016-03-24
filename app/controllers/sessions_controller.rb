#This class controller handles the login and sign up values with appropriate references to the database
class SessionsController < ApplicationController
  skip_before_action :authorize, :only => [:create, :destroy]
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    password = params[:password]
    email = params[:email]
    if email.nil?
      result = {msg: :"error", detail: :"email_nil"}
    elsif password.nil?
      result = {msg: :"error", detail: :"password_nil"}
    elsif !email.nil? && !password.nil?
      account = Account.find_by(email: email)
      if account.nil?
        result = {msg: :"error", detail: :"invalid_account"}
      elsif !account.authenticate(password) && !account.nil?
        result = {msg: :"error", detail: :"wrong_password"}
      elsif !account.email_confirmed && !account.nil?
        result = {msg: :"error", detail: :"not_activated"}
      elsif !account.nil? && account.authenticate(password) && account.email_confirmed
        session[:account_id] = account.id
        acc = Account.find(session[:account_id])
        guildmaster = acc.guildmaster
        if !guildmaster.nil?
          guilds = guildmaster.guilds.as_json(except: [:created_at, :updated_at])
          result = {msg: :"success", guilds: guilds}
        elsif guildmaster.nil?
          result = {msg: :"error", detail: :"guildmaster_not_created"}
        end
      end
    end
    render json: result.as_json
  end

  # DELETE /sessions.json
  def destroy
    reset_session
    result = {msg: :"success"}
    render json: result.as_json
  end
end
