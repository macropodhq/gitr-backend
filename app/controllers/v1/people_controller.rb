class V1::PeopleController < V1::ApplicationController
  def index
    @users = User.limit(5).where.not(id: [current_user.id] + current_user.matches.map(&:other_user_id)).order('last_seen_at').where('avatar_url is not null')
  end

  def show
    @user = User.find(params[:id])
  end
end
