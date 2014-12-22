class V1::PeopleController < V1::ApplicationController
  def index
    @users = User.limit(5).where('id <> ?', current_user.id)
  end

  def show
    @user = User.find(params[:id])
  end
end
