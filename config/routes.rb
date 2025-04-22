Rails.application.routes.draw do
  devise_for :admins
  scope :paid_leaves, only: [:index] do
    resources :requests, only: [:create, :new]
    resources :approval, only: [:edit, :update, :show]
  end
  resources :alcohol_logs, only: [:index, :show, :new, :create, :edit, :update]
  root to: 'paid_leaves#index'

  resources :alcohol_logs, only: [:index, :show] do
    collection do
      resources :drive_be_logs, only: [:create, :new]
      resources :drive_af_logs, only: [:create, :new]
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
end
# ローカルでつなぐとき
# https://cucumber.localhost:3000
