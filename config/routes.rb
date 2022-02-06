Rails.application.routes.draw do
  resources :tokens do
    member do
      get :activate
    end
  end

  resources :users do
    collection do
      get :logout
    end
  end

  resources :invoices

  get '/api_doc', to: 'invoices#api_doc'

  root "tokens#index"
end
