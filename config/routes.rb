# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[create destroy] do
    get 'can', on: :collection
  end

  post '/auth/login', to: 'authentication#login'

  resources :people
  resources :things
  resources :groups do
    resources :things, except: %i[show], controller: 'group_things'
  end

  get 'health', action: :index, controller: 'healths'
end
