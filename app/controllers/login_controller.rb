class LoginController < ApplicationController
  skip_before_filter :login_required

  def login
    client = Octokit::Client.new
    url = client.authorize_url(ENV['OCTOKIT_CLIENT_ID'])
    redirect_to url
  end

  def callback
    session_code = params[:code]
    result = Octokit.exchange_code_for_token(session_code, ENV['OCTOKIT_CLIENT_ID'], ENV['OCTOKIT_SECRET'])

    client = Octokit::Client.new(access_token: result[:access_token])

    # user rarely gets created here. full details filled in during oauth/jwt swap by api
    user = User.find_or_create_by(login: client.user.login)
    user.login = client.user.login
    user.github_id = client.user.id
    user.public_repos = client.user.public_repos
    user.public_gists = client.user.public_gists
    user.followers = client.user.followers
    user.following = client.user.following
    user.save!

    session[:user_id] = user.id
    session[:access_token] = result[:access_token]

    redirect_to '/'
  end
end
