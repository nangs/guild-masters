#This class controller handles the login and sign up values with appropriate references to the database
class SessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    password = params[:password]
    email = params[:email]
    account = Account.find_by(email: email)
    if account.nil?
      msg = {msg: "error", detail: "invalid_account"}
      render json: msg.as_json
    elsif !account.authenticate(password) && !account.nil?
      msg = {msg: "error", detail: "wrong_password"}
      render json: msg.as_json
    elsif !account.email_confirmed && !account.nil?
      msg = {msg: "error", detail: "not_activated"}
      render json: msg.as_json
    elsif !account.nil? && account.authenticate(password) && account.email_confirmed
      session[:account_id] = account.id
      acc = Account.find(session[:account_id])
      guildmaster = acc.guildmaster
      if !guildmaster.nil?
        guilds = guildmaster.guilds.as_json(except: [:created_at, :updated_at])
        msg = {msg: "success", guilds: guilds}
      elsif guildmaster.nil?
        msg = {msg: "error", detail: "guildmaster_not_created"}
      end
      render json: msg.as_json
    end
  end

  # DELETE /sessions.json
  def destroy
    reset_session
    msg = {msg: "success"}
    render json: msg
  end

end
