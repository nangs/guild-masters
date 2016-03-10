class AdminController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  before_action :authorize
  protected
  respond_to :json

  def authorize

  end

end
