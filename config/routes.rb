Rails.application.routes.draw do
  namespace :v1 do
    resource :people
    resource :authorize
    resources :matches
  end
end
