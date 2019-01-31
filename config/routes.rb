Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'search', to: 'search#search'
  get 'users/signup'
  get 'users/new_user'
  get 'urls/new'
  get 'urls/logout'
  get 'urls/short_to_long'
  get 'domains/new'
  get 'conversions/index'

  post 'users/username_available'
  post 'users/signup_entry'
  post 'users/login'
  post 'urls/long_to_short'
  post 'domains/create_domain'

  root 'users#new_user'

  require 'sidekiq/web'	
  get '*path' => redirect('/')
mount Sidekiq::Web, :at => '/sidekiq'
end
