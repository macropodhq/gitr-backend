class User < ActiveRecord::Base
  has_many :matches, dependent: :destroy
  has_many :messages, dependent: :destroy

  def generate_jwt
    JWT.encode({
                   user_id: id,
                   exp: 1.day.from_now.to_i
               },
               ENV['JWT_SECRET_KEY']
    )
  end

  def channel
    Digest::SHA1.hexdigest('PUBSUB_SALT' + id)
  end

  def push_message(message)
    pubnub = Pubnub.new(
        :publish_key => ENV['PUBNUB_PUBLISH_KEY'],
        :subscribe_key => ENV['PUBNUB_SUBSCRIBE_KEY']
    )

    pubnub.publish(
        :channel => channel,
        :message => message
    ) { |data| puts data.response }

  end

  def update_from_github(github_user)
    self.login = github_user.login
    self.avatar_url = github_user.avatar_url
    self.github_id = github_user.id
    self.public_repos = github_user.public_repos
    self.public_gists = github_user.public_gists
    self.followers = github_user.followers
    self.following = github_user.following
    self.location = github_user.location
    self.name = github_user.name
    repos = Octokit.repositories(github_user.login).map { |r| r.attrs.slice(:name, :description, :language, :forks, :watchers, :pushed_at, :full_name) }.sort { |a, b| a[:pushed_at].to_i <=> b[:pushed_at].to_i }.reverse[0, 3]

    repos.each do |repo|
      begin
        repo[:readme] = open("https://raw.githubusercontent.com/#{repo[:full_name]}/master/README.md").read[0,500]
      rescue OpenURI::HTTPError
      end
    end
    self.repos = repos
    self.bio = github_user.bio
    self.company = github_user.company
    self.save!
  end
end
