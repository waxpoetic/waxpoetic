Rails.application.routes.draw do
  resources :subscribers
  resources :artists do
    resources :releases
  end

  devise_for :users
  devise_scope :user do
    get     '/signup' => 'devise/registrations#new'
    get     '/login'  => 'devise/sessions#new'
    delete  '/logout' => 'devise/sessions#destroy'
  end

  get '/:id' => 'high_voltage/pages#show', :as => :static_page
  root to: 'high_voltage/pages#show', id: 'home'
end
