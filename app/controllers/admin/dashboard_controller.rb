class Admin::DashboardController < AdminController
  before_action :authorized_admin, except: [:new]
  def index
  end
end
