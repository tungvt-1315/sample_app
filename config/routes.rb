Rails.application.routes.draw do
  resources :products
  get 'static_pages/home'
  get 'static_pages/help'

end
