Rails.application.routes.draw do
  namespace :v1 do
    resources :people
    resource :profile
    resources :matches do
      resources :messages
    end
  end

  get '/auth', to: 'login#auth'
  get '/callback', to: 'login#callback'
  get '/status', to: 'status#index'
end
