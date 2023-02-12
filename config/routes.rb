Rails.application.routes.draw do
  resources :topics
  resources :posts
  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations'
  }
  resources :account_posts 
  post 'account_posts/:user_id/:post_id', to: 'account_posts#create'
  delete 'account_posts/:post_id/:user_id', to: 'account_posts#destroy'
  put 'account_posts/:post_id/:user_id', to: 'account_posts#unlike'
  delete 'accounts/:id', to: 'accounts#destroy'
  resources :posts do
    resources :references, only: [:index, :show, :create, :update, :destroy]
  end
  
  put '/posts', to: 'posts#assign_to_topic'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
