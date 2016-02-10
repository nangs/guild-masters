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
      respond_to do |format|
        format.json { render json: 'error: email not valid'.to_json}
      end
    elsif !account.authenticate(password)
      respond_to do |format|
        format.json { render json: 'error: wrong password'.to_json}
      end
    elsif !account.email_confirmed
      respond_to do |format|
        format.json { render json: 'error: not activated'.to_json}
      end
    elsif !account.nil? && account.authenticate(password) && account.email_confirmed
      session[:account_id] = account.id
      respond_to do |format|
        format.json { render json: 'success'.to_json}
      end
    end
  end

  # DELETE /sessions/1.json
  def destroy
    session[:account_id] = nil
    respond_to do |format|
      format.json { render json: 'destroyed'.to_json}
    end
  end

end
