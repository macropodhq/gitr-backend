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

    if match.match && other.matches.find_by(other_user_id: current_user, match: true)
      # we have a match!
      render status: :created, json: {status: 'Matched with other user'}
      current_user.push_message({
                                    type: 'match',
                                    other_user_id: other.id,
                                    match_id: match.id
                                })
      other.push_message({
                                    type: 'match',
                                    other_user_id: other.id,
                                    match_id: match.id
                                })
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

  def show
    @match = current_user.matches.find_by!(other_user_id: params[:id])

    @messages = Message.find_by_sql ['select * from messages where (user_id=:current_user_id AND other_user_id=:other_user_id) OR (user_id=:other_user_id AND other_user_id=:current_user_id)', {current_user_id: current_user.id, other_user_id: @match.other_user_id}]
  end
end
