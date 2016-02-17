class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  before_action :authorize
  protected
  def authorize
    unless Account.find_by(id: session[:account_id])
      # rendering to json is not needed.
      # respond_to do |format|
      #   format.json { render json: 'unauthorized'.to_json}
      # end
      return 'unauthorized'
    end
  end
end
