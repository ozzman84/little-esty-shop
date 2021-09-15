Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'application#welcome'
  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/merchants/:merchant_id', to: 'admin_merchants#show'
  get '/admin/merchants/:merchant_id/edit', to: 'admin_merchants#edit'
  patch '/admin/merchants/:merchant_id', to: 'admin_merchants#update'

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants, except: [:destroy]
    resources :merchant_status, only: [:update]
    resources :invoices, except: [:new, :destroy]
  end

  resources :merchant, only: [:show] do
    resources :dashboard, only: [:index]
    resources :items, except: [:destroy]
    resources :item_status, only: [:update]
    resources :invoices, only: [:index, :show, :update]
  end
end
