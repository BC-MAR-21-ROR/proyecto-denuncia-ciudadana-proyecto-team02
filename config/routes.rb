Rails.application.routes.draw do
  devise_for :users

  resources :denounces

  scope :api do
    get 'municipalities', to: 'municipalities#index'
    get 'settlements', to: 'settlements#index'
    get 'postal_codes', to: 'postal_codes#index'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#show' # denounces according to places of interest
end
