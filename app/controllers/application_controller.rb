class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :login_required

  def login_required
    if session[:user_id].blank?
      redirect_to '/login'
      return
    end

    current_user
  end

  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    reset_session
    redirect_to '/'
  end
end
