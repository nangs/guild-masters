#This class controller handles the login and sign up values with appropriate references to the database
class SessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :verify_authenticity_token

  def new
  end

  def create
    password = params[:password]
    email = params[:email]
    account = Account.find_by(email: email)
    if account.nil?
      msg = {msg: "error", detail: "invalid_account"}
      respond_to do |format|
        format.json { render json: msg.to_json}
      end
    elsif !account.authenticate(password)
      msg = {msg: "error", detail: "wrong_password"}
      respond_to do |format|
        format.json { render json: msg.to_json}
      end
    elsif !account.email_confirmed
      msg = {msg: "error", detail: "not_activated"}
      respond_to do |format|
        format.json { render json: msg.to_json}
      end
    elsif !account.nil? && account.authenticate(password) && account.email_confirmed
      session[:account_id] = account.id
      account.save
      msg = {msg: "success"}
      respond_to do |format|
        format.json { render json: msg.to_json}
      end
    end
  end

  # DELETE /sessions/1.json
  def destroy
    session[:account_id] = nil
    msg = {msg: "success"}
    respond_to do |format|
      format.json { render json: msg.to_json}
    end
  end

end
