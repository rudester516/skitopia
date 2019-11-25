Rails.application.routes.draw do

  root 'home#index'
  get 'home/product/:id', to: 'home#product', as: :product
  get 'home/weather'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
