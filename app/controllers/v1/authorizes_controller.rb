class V1::AuthorizesController < V1::ApplicationController
  skip_before_filter :login_required

  def create
    client = Octokit::Client.new(access_token: params[:token])

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

    render json: {token: jwt}
  end
end
