Rails.application.routes.draw do
  root to: 'api/posts#index'

  namespace :api, defaults: { format: :json } do
    resources :posts
  end
end
