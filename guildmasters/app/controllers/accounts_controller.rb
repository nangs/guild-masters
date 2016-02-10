class AccountsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create, :index]
  skip_before_action :verify_authenticity_token



########
########for testing not for release
########
# GET /accounts.json
  def index
    accounts = Account.all
    respond_to do |format|
      format.json { render json: accounts }
    end
  end
########
########for testing not for release
########




# POST /accounts.json
#When a POST is done with parameters email and password, this function will check with if the post is a signup or login
#it will then redirect to the respective function in the model
#it then returns a json format of what the model returns
  def create
    if params[:cmd] == 'signup'
      email = params[:email]
      password = params[:password]
      account = Account.create_account(email,password)
    elsif params[:cmd] == 'activate_account'
      email = params[:email]
      confirm_token = params[:confirm_token]
      account = Account.activate_account(email,confirm_token)
    end
    respond_to do |format|
      format.json { render json: account.to_json}
    end
  end

  def show
    acc = Account.find(params[:id])
    gm = acc.guildmaster
    respond_to do |format|
      format.json { render json: gm }
    end
  end
end