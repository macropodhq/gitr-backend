class V1::PeopleController < V1::ApplicationController
  def show
    @users = User.limit(5).where('id <> ?', current_user.id)
  end
end
