json.person do
  json.partial! 'v1/users/user', user: @match.other_user
end

json.messages do
  json.partial! 'v1/messages/message', collection: @messages, as: :message
end
