class V1::ApplicationController < ::ApplicationController
  protect_from_forgery with: :null_session

  def login_required
    result = JWT.decode(params[:token], ENV['JWT_SECRET_KEY'])

    @current_user == User.find(result[0]['user_id'])
  end
end