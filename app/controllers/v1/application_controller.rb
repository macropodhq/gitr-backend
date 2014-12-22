class V1::ApplicationController < ::ApplicationController
  protect_from_forgery with: :null_session

  def login_required
    token = request.headers['Authorization'].split(' ').last
    token = params[:token] if token.blank?
    result = JWT.decode(token, ENV['JWT_SECRET_KEY'])

    @current_user = User.find(result[0]['user_id'])
  rescue JWT::ExpiredSignature
    render status: :unauthorized, json: {error: 'JWT expired'}
  end
end