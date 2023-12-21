Rails.application.routes.draw do
  root to: 'dishes#new'
  get 'sign_up', to: 'users#new'
  post 'sign_up', to: 'users#create'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'pages/terms_of_use', to: 'high_voltage/pages#show', id: 'terms_of_use'
  get 'pages/privacy', to: 'high_voltage/pages#show', id: 'privacy'

  # sorceryを使った外部認証
  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider

  resources :users, param: :uuid, only: %i[create show] do
    get 'my_dishes', on: :collection
  end
  resources :dishes, param: :uuid do
    get 'result', on: :member
    patch 'publish', on: :member
    get 'likes', on: :collection
  end
  resource :profile, only: %i[edit update]
  resources :password_resets, only: %i[new create edit update]
  resources :likes, param: :uuid, only: %i[create destroy]

  namespace :admin do
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    root to: 'dashboards#index'
    resources :dishes, only: %i[index show destroy], param: :uuid
    resources :users, only: %i[index destroy], param: :uuid
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development? # ローカルはletter_openerを使う
end
