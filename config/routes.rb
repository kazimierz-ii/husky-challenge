Rails.application.routes.draw do
  resources :tokens, only: [:index, :create] do
    member do
      get :activate
    end
  end

  resources :users, only: :create do
    collection do
      get :logout
    end
  end

  resources :invoices, except: :destroy

  get '/api_doc', to: 'invoices#api_doc'

  root "tokens#index"
end
