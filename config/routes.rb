Rails.application.routes.draw do
  get 'home/search'
  root to: 'home#search'

  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
