class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  skip_before_action :authorize
  skip_before_action :authorized_admin

  protected

  respond_to :json

  def authorize
    unless Account.find_by(id: session[:account_id])
      # redirect to index
      render status: 401, text: 'Error 401: Sorry, you are unauthorized'
    end
  end

  def authorized_admin
    unless Account.find_by(id: session[:admin_id])
      # redirect to index
      render status: 401, text: 'Error 401: Sorry, you are unauthorized'
    end
  end
end
