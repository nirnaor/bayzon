Rails.application.routes.draw do
  get 'home/search'
  root to: 'home#search'

  get 'home/index'
  get 'product_name', to: "home#product_name"

  get 'sellers', to: "home#sellers"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
