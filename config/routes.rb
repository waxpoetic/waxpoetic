Rails.application.routes.draw do
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
  end
  resources :releases, only: [:index, :show]
  resources :articles, only: [:index, :show]

  devise_for :users
  devise_scope :user do
    get '/signup' => 'devise/registrations#new'
    get '/login'  => 'devise/sessions#new'
    delete '/logout' => 'devise/sessions#destroy'
  end

  root to: 'articles#index'
end
