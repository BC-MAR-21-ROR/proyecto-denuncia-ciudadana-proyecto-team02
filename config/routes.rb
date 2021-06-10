Rails.application.routes.draw do
  resources :place_of_interests
  devise_for :users

  resources :denounces
  resources :likes, only: %i[create destroy]

  scope :api do
    get 'municipalities', to: 'municipalities#index'
    get 'settlements', to: 'settlements#index'
    get 'postal_codes', to: 'postal_codes#index'
    get 'settlements/:postal_code', to: 'settlements#show'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index' # denounces according to places of interest  resources :denounces
end
