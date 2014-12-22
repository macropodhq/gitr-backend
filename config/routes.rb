Rails.application.routes.draw do
  get '/login', to: 'login#login'
  get '/callback', to: 'login#callback'
  get '/', to: 'dashboard#index'
  namespace :v1 do
    resource :people
    resource :authorize
    resources :matches
  end
end
