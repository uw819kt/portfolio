Rails.application.routes.draw do
  resources :paid_leaves, only: [:index, :show] do
    collection do
      resources :request, only: [:create, :new]
      # resources :approval, only: [:edit, :update]
    end
  end
  resources :alcohol_logs, only: [:index, :show, :new, :create, :edit, :update]
  root to: 'paid_leaves#index'
end
