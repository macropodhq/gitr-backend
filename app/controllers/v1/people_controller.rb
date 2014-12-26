class V1::PeopleController < V1::ApplicationController
  def index
    @users = User.find_by_sql ["select users.* from matches inner join users on matches.user_id=users.id where other_user_id=:user_id and match='y' and user_id not in (select other_user_id from matches where user_id=:user_id);", user_id: current_user.id]
    @users = User.limit(5).where.not(id: [current_user.id] + current_user.matches.map(&:other_user_id)).order('last_seen_at').where('avatar_url is not null') if @users.empty?
  end

  def show
    @user = User.find(params[:id])
  end
end
