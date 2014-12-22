json.people do
  json.partial! 'v1/users/user', collection: @users, as: :user
end