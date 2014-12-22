class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :login_required

  def login_required
    reset_session

    render status: :unauthorized, json: {status: 'Action not authorised'}
    return
  end
end
