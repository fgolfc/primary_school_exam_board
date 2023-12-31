Rails.application.routes.draw do
  root to: 'homes#top'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }
  resources :users, only: [:index, :show], path: 'profile'
  resources :posts, only: [:index, :show, :new, :create, :destroy] do
    resources :responses, only: [:new, :create, :destroy]
    resources :post_likes, only: [:create, :destroy]
  end
  resources :responses do
    resources :response_likes, only: [:create, :destroy]
  end
  resources :notifications, only: [:create]
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/users', to: redirect("/users/sign_up")
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  get 'homes/top', to: 'homes#top', as: 'homes_top'
  get '/top', to: 'homes#top'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
