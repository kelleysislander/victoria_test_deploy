class DashboardController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    # @users = User.find_by_sql(["Select * FROM users u WHERE u.id != ?", current_user.id])
    # @users = User.all.excludes(:id => current_user.id)
  end
  
end