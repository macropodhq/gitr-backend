class V1::MatchesController < V1::ApplicationController
  def create
    other = User.find_by_id(params[:person][:id])
    unless other
      render status: 406, json: {status: 'Other user not found'}
      return
    end

    match = current_user.matches.find_or_create_by(other_user_id: other.id)
    match.match = params[:match]
    match.save!

    if match && Match.find_by(other_user_id: current_user, match: true)
      # we have a match!
      render status: :created, json: {status: 'Matched with other user'}
      return
    end

    render status: :accepted, json: {status: 'Match recorded'}
  end

  def index
    @matches = current_user.matches.matched.map(&:other_user)
  end

  def destroy
    current_user.matches.find_by!(other_user_id: params[:id]).destroy
    render json: {status: 'Match removed'}
  end
end
