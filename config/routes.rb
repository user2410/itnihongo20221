Rails.application.routes.draw do
  resources :posts
  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations'
  }
  delete 'accounts/:id', to: 'accounts#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
