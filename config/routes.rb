Rails.application.routes.draw do
  root to: 'ucb_rails/home#index'
  
  match 'ucb_rails', :to => 'ucb_rails/home#index'
  
  match '/login', :to => 'ucb_rails/sessions#new', :as => 'login'
  match '/logout', :to => 'ucb_rails/sessions#destroy', :as => 'logout'
  match '/auth/:omniauth_provider/callback' => 'ucb_rails/sessions#create'
  match '/auth/failure' => "ucb_rails/sessions#failure"
  match '/not_authorized', :to => 'ucb_rails/sessions#not_authorized', as: 'not_authorized'
  
  match '/ucb_rails/bootstrap(/:uid)' => 'ucb_rails/bootstrap#index'
  
  resources :hidden_announcements, path: '/announcements', only: [:index, :create, :destroy]

  namespace :ucb_rails do
    get '/ldap_person_search' => 'ldap_person_search#search', :as => :ldap_person_search
    get '/ldap_person_search_add_user' => 'ldap_person_search#search_add_user', :as => :add_user_search
    
    namespace :admin do
      resources :announcements
      resources :users
    end
  end
  
end
