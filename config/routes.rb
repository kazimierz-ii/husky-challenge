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

  root "tokens#index"
end
