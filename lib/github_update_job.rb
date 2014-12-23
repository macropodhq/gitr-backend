class GithubUpdateJob < Struct.new(:github_login)
  def perform
    user = User.find_by!(login: github_login)
    user.update_from_github(Octokit.user(github_login))
  end
end