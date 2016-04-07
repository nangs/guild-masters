class AdminController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  before_action :authorize
  protected
  respond_to :json

  def authorize
  	acc = Account.find_by(id: session[:account_id])
    if acc
      if !acc.is_admin
        redirect_to '/'
      end
    else
      redirect_to '/'
    end
  end

end
