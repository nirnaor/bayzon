Rails.application.routes.draw do
  get 'home/search'
  root to: 'home#search'

  get 'home/index'
  get 'fetch_sellers', to: "home#fetch_sellers"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
