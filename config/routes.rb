# = Routing Table
#
# Describes the various URL endpoints of the web app. This is also
# where we converge Spree and the other engines that we use to power
# this application.
Rails.application.routes.draw do
  # == User Authentication
  #
  # Global user authentication scheme that is used in both the online
  # store and the "front-end" catalog site for administration. Anyone
  # can register an account, but only admins may edit the catalog site.
  # Indeed, account registration is required to purchase items on the
  # online store at this time.
  devise_for :users
  devise_scope :user do
    get     '/signup' => 'devise/registrations#new'
    get     '/login'  => 'devise/sessions#new'
    delete  '/logout' => 'devise/sessions#destroy'
  end

  # == Catalog
  #
  # The main marketing site and basic place to find information on the
  # label.
  resources :artists do
    resources :photos, only: %w(new create edit update destroy)
  end
  resources :releases

  # == Online Store
  #
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to
  # Spree::ProductsController. We ask that you don't use the :as option
  # here, as Spree relies on it being the default of "spree".
  mount Spree::Core::Engine, :at => '/store'

  # == Debug Console
  #
  # Unless we're in production (wherein the server is exposed to the
  # general public), mount a web console at /console for access to the
  # Rails app on a programmatic level.
  mount WebConsole::Engine, :at => '/console' if defined? WebConsole

  # == Static pages
  #
  # Company and licensing information.
  get '/:id' => 'high_voltage/pages#show', :as => :static_page
  root to: 'high_voltage/pages#show', id: 'home'
end
