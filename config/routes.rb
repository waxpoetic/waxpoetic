Rails.application.routes.draw do
  resources :events
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  resources :subscribers, only: [:new, :create, :show]
  resources :artists, only: [:index, :show] do
    resources :releases, only: [:index]
    resources :subscribers, only: [:new]
    resources :events, only: [:index, :show]
  end
  resources :releases, only: [:index, :show]
  resources :articles, only: [:index, :show]
  resource :search, only: [:show]

  devise_for :users
  devise_scope :user do
    get '/signup' => 'devise/registrations#new'
    get '/login'  => 'devise/sessions#new'
    delete '/logout' => 'devise/sessions#destroy'
  end

  get 'podcast', to: 'articles#podcast'
  get ':id', to: 'high_voltage/pages#show'

  root to: 'articles#home'
end
