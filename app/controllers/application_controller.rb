class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  before_action :authorize
  protected
  respond_to :json

  def authorize
    unless Account.find_by(id: session[:account_id])
      #redirect to index
      render action: "index"
    end
  end

end
