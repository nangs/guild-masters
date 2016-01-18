class AccountsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create, :index]
  skip_before_action :verify_authenticity_token
# GET /accounts.json
  #for testing not for release
  def index
    accounts = Account.all
    respond_to do |format|
      format.json { render json: accounts }
    end
  end

# GET /accounts/1.json
#for testing not for release
  def show
    accounts = Account.all
    respond_to do |format|
      format.json { render json: accounts }
    end
  end

  #GET /accounts/new
  def new
    account = Account.new
  end

  #GET /accounts/1/edit
  def edit
  end

  # POST /accounts.json
  def create
      username = params[:username]
      password = params[:password]
      email = params[:email]
      account = Account.generate(username,password,email)
      respond_to do |format|
        format.json { render json: account.to_json}
      end
  end

  #PUT /accounts/1.json
  def update
    respond_to do |format|
      if account.update(username,password)
        format.html { redirect_to accounts_url, notice: 'Account was successfully updated.'}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: account.errors, status: :unprocessable_entity }
      end
    end
  end
end