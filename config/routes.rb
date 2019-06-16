Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'application/get_items'
  post 'application/get_items'
  get 'application/search'
  get 'application/open_browser'
  
  root 'application#search'
end
