Rails.application.routes.draw do
  resources :topics
  resources :posts
  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations'
  }
  delete 'accounts/:id', to: 'accounts#destroy'
  
  put '/posts', to: 'posts#assign_to_topic'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
