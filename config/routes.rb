Rails.application.routes.draw do
  devise_for :users,
    controllers: { sessions: "devise/passwordless/sessions" }

  # ゲストログイン用ルート
  devise_scope :user do
    post "users/guest_sign_in", to: "users/guest_sessions#guest_sign_in"
    post "users/guest_admin_sign_in", to: "users/guest_sessions#guest_admin_sign_in"
  end

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
    resources :pdf_paid_leave, only: :index
  end

  resources :paid_leaves, only: [ :index, :edit, :update ]
  root to: "paid_leaves#index"

  resources :alcohol_logs, only: [ :index, :show ] do
    collection do
      resources :pdf_alcohole, only: :index
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
    mount LetterOpenerWeb::Engine, at: "/letter_opener", protocol: "https"
  end
end
# ローカルでつなぐとき
# https://cucumber.localhost:3000/users/sign_in
