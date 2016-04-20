class Admin::AccountsController < AdminController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :authorized_admin

  def index
    @grid = AccountsGrid.new(params[:accounts_grid]) do |scope|
      scope.page(params[:page])
    end
  end

  def show
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to [:admin, @account], notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to [:admin, @account], notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to admin_accounts_path, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:username, :email, :email_confirmed, :is_admin, :is_logged_in)
  end
end
