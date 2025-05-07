Rails.application.routes.draw do
  devise_for :admins
  passwordless_for :users

  scope :admins do
    resources :users do
      resources :cars, only: [ :new, :create, :update ]
      resources :paid_leaves, only: [ :new, :create ]
      resources :grants, only: [ :new, :create, :edit, :update ]
    end
  end

  scope :paid_leaves do
    resources :requests, only: [ :index, :create, :new, :show ]
  end

  resources :paid_leaves, path: "paid_leaves", as: "paid_leaves" do
    resources :approvals, only: [ :new, :create, :edit, :update, :show ]
  end

  resources :alcohol_logs, only: [ :index, :show, :new, :create, :edit, :update ]

  resources :paid_leaves, only: [ :index, :edit, :update ]
  root to: "paid_leaves#index"

  resources :alcohol_logs, only: [ :index, :show ] do
    collection do
      resources :drive_be_logs, only: [ :create, :new, :edit, :update ]
      resources :drive_af_logs, only: [ :create, :new, :edit, :update ]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
# ローカルでつなぐとき
# https://cucumber.localhost:3000
