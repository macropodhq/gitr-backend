class V1::PeopleController < V1::ApplicationController
  def show
    @users = User.limit(5)
  end
end
