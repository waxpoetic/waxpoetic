Rails.application.routes.draw do
  # User Authentication
  devise_for :users

  # Artist/Release CMS
  resources :artists
  resources :releases

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to
  # Spree::ProductsController. We ask that you don't use the :as option
  # here, as Spree relies on it being the default of "spree".
  mount Spree::Core::Engine, :at => '/store'

  # Static pages
  get '/info/:id' => 'high_voltage/pages#show'
  root to: 'high_voltage/pages#show', id: 'home'
end
