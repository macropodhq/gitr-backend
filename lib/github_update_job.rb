class GithubUpdateJob < Struct.new(:github_login)
  def perform
    user = User.find_by!(login: github_login)

    client = Octokit::Client.new(access_token: user.github_access_token)
    user.update_from_github(client.user(github_login))
  end
end