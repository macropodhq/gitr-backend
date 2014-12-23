json.person do
  json.partial! 'v1/users/user', user: @match.other_user
end
json.messages @messages do |message|
  json.(message, :created_at, :text)
  json.from message.user.id
end