class V1::AuthorizesController < V1::ApplicationController
  skip_before_filter :login_required

  def create
    if params[:code]
      result = Octokit.exchange_code_for_token(params[:code])
      access_token = result[:access_token]
    end
    client = Octokit::Client.new(access_token: access_token)

    user = User.find_or_create_by(login: client.user.login)
    user.login = client.user.login
    user.avatar_url = client.user.avatar_url
    user.github_id = client.user.id
    user.public_repos = client.user.public_repos
    user.public_gists = client.user.public_gists
    user.followers = client.user.followers
    user.following = client.user.following
    user.location = client.user.location
    user.name = client.user.name
    user.save!

    jwt = user.generate_jwt

    render json: {
               token: jwt,
               id: user.id,
               login: user.login,
               avatar_url: user.avatar_url,
               location: user.location,
               name: user.name
           }
  end
end
