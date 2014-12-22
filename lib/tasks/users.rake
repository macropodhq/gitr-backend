namespace :users do
  desc 'Import user bson dump'
  task :import_bson => :environment do
    file = File.open 'users.bson'

    loop do
      hash = Hash.from_bson(file)

      user = User.find_or_create_by(github_id: hash['id'])
      user.login = hash['login']
      user.avatar_url = hash['avatar_url']
      user.public_repos = hash['public_repos']
      user.public_gists = hash['public_gists']
      user.followers = hash['followers']
      user.following = hash['following']
      user.save!
      user.reload

      break if hash.nil?
    end
  end
end