class V1::MessagesController < V1::ApplicationController
  def create
    if params[:text].blank?
      render status: :not_acceptable, json: {status: 'No message text'}
      return
    end

    match = current_user.matches.find_by!(other_user_id: params[:match_id])
    current_user.messages.create!(other_user: match.other_user, text: params[:text])

    render status: :created, json: {status: 'Created'}
  end
end
