# frozen_string_literal: true

Rails.application.routes.draw do
  resources :searches do
    collection do
      get 'search'
      get 'shared' => 'shared_searches#index'
    end

    get 'shared' => 'shared_searches#show'

    resource :exports, only: %i[new show]
  end

  resources :tags, only: %i[index new create destroy]
  resources :things, except: %i[index] do
    resources :comments, only: %i[create update destroy]
  end

  resource :license, only: %i[show]
  resource :sessions, only: %i[new create destroy]

  # Provided by Rails for health checking :)
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'searches#index'
end
