Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'users/signup'
  get 'users/new_user'
  get 'urls/new'

  post 'users/signup_entry'
  post 'users/login'
  post 'urls/convert_long'
  post 'urls/convert_short'

  root 'users#new_user'

  require 'sidekiq/web'	
mount Sidekiq::Web, :at => '/sidekiq'
end
