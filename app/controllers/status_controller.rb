class StatusController < ApplicationController
  skip_before_filter :login_required
  newrelic_ignore
  
  def index
    User.first
    render status: :ok, text: 'OK'
  end
end
