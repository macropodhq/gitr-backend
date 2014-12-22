json.person do
  json.partial! 'v1/users/user', user: current_user
end