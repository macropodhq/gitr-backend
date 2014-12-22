class DashboardController < ApplicationController
  def index
    @user_count = User.count
  end
end
