Rails.application.routes.draw do
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  resources :subscribers, only: [:new, :create, :show]
  resources :artists, only: [:index, :show] do
    resources :releases, only: [:index, :show]
  end

  devise_for :users
  devise_scope :user do
    get '/signup' => 'devise/registrations#new'
    get '/login'  => 'devise/sessions#new'
    delete '/logout' => 'devise/sessions#destroy'
  end

  get '/:id' => 'high_voltage/pages#show', :as => :static_page
  root to: 'high_voltage/pages#show', id: 'home'
end
