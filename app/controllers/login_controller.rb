class LoginController < ApplicationController
  skip_before_filter :login_required

  def auth
    if params[:redirect_uri].blank?
      render status: :not_acceptable, text: 'No redirect uri'
      return
    end

    session[:redirect_uri] = params[:redirect_uri]

    redirect_to Octokit::Client.new.authorize_url
  end

  def callback
    if params[:code].blank?
      render status: :not_acceptable, text: 'No code param'
      return
      end

    result = Octokit.exchange_code_for_token(params[:code])
    access_token = result[:access_token]
    client = Octokit::Client.new(access_token: access_token)

    uri = URI.parse(session[:redirect_uri])
    unless uri.hostname == 'app.gitr.io'
      #check for auth shenanigans
      unless client.organization_member?('macropodhq', client.user.login)
        render status: :forbidden, text: 'Redirect url must be to app.gitr.io'
        return
      end
    end

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

    redirect_to session[:redirect_uri] + '?token=' + jwt
  end
end
