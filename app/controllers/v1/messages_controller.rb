class V1::MessagesController < V1::ApplicationController
  def create
    if params[:text].blank?
      render status: :not_acceptable, json: {status: 'No message text'}
      return
    end

    match = current_user.matches.find_by!(other_user_id: params[:match_id])
    @message = current_user.messages.create!(other_user: match.other_user, text: params[:text])

    current_user.push_message({
                                  type: 'message',
                                  created_at: @message.created_at,
                                  text: @message.text,
                                  from: @message.user.id
                              })

    @message.other_user.push_message({
                                  type: 'message',
                                  created_at: @message.created_at,
                                  text: @message.text,
                                  from: @message.user.id
                              })

    render status: :created
  end
end
