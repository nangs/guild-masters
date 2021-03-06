# This class controller handles all admin controllers
class AdminController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  layout "admin"
end
