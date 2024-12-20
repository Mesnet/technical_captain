# frozen_string_literal: true
Rails.application.routes.draw do
  resources :battles, only: %i[index show new create]
  resources :characters
  resources :weapons
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#index'
end
