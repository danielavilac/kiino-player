Rails.application.routes.draw do
  root "videos#index"
  resources :videos, only: [:index]
  
  namespace :api, defaults: {format: 'plain'} do
    namespace :v1 do
      get '/push', to: 'videos#push', as: 'push'
    end
  end
end
