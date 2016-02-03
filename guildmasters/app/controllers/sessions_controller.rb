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
        format.json { render json: 'error'.to_json}
      end
    elsif !account.nil? and account.authenticate(password)
      session[:account_id] = account.id
      respond_to do |format|
        format.json { render json: account.to_json}
      end
    end
  end

  def destroy
    session[:account_id] = nil
    respond_to do |format|
      format.json { render json: 'destroyed'.to_json}
    end
  end

end
