Rails.application.routes.draw do
  resources :subscribers
  # Catalog resources
  resources :artists
  resources :releases
  resources :events do
    resources :tickets, only: %w(index)
  end

  # User Authentication
  devise_for :users
  devise_scope :user do
    get     '/signup' => 'devise/registrations#new'
    get     '/login'  => 'devise/sessions#new'
    delete  '/logout' => 'devise/sessions#destroy'
  end

  # Static pages
  get '/:id' => 'high_voltage/pages#show', :as => :static_page
  root to: 'high_voltage/pages#show', id: 'home'
end
