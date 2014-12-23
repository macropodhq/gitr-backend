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
    github_user = client.user
    unless uri.hostname == 'app.gitr.io' || uri.hostname == 'gitr.io'
      #check for auth shenanigans
      unless client.organization_member?('macropodhq', github_user.login)
        render status: :forbidden, text: 'Redirect url must be to gitr.io'
        return
      end
    end

    user = User.find_or_create_by(login: github_user.login)
    user.last_seen_at = Time.now
    user.save!
    Delayed::Job.enqueue GithubUpdateJob.new(github_user.login)

    jwt = user.generate_jwt

    redirect_to session[:redirect_uri] + '?token=' + jwt
  rescue Octokit::Unauthorized
    redirect_to '/auth'
  end
end
