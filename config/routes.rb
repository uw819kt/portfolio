Rails.application.routes.draw do
  devise_for :admins
  scope :paid_leaves, only: [:index] do
    resources :requests, only: [:create, :new, :show]
    resources :approvals, only: [:new, :create, :edit, :update, :show]
  end
  resources :alcohol_logs, only: [:index, :show, :new, :create, :edit, :update]
  root to: 'paid_leaves#index'
end
# ローカルでつなぐとき
# https://cucumber.localhost:3000
