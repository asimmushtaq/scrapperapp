Rails.application.routes.draw do

  get 'food_items/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'application/get_items'
  # post 'application/get_items'
  #   get 'application/search'
  resources :food_items
  get 'datascrapper/get_items'
  post 'datascrapper/get_items'
  get  'datascrapper/open_browser'


  get 'application/search'
  root 'application#search'
end
