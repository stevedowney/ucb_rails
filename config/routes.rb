Rails.application.routes.draw do
  root to: 'ucb_rails/home#index'
  
  match 'ucb_rails', :to => 'ucb_rails/home#index'
  
  match '/login', :to => 'ucb_rails/sessions#new', :as => 'login'
  match '/logout', :to => 'ucb_rails/sessions#destroy', :as => 'logout'
  match '/auth/:provider/callback' => 'ucb_rails/sessions#create'
  match '/auth/failure' => "ucb_rails/sessions#failure"
  
  resources :hidden_announcements, path: '/announcements', only: [:index, :create, :destroy]

  namespace :ucb_rails do
    get '/ldap_person_search' => 'ldap_person_search#search', :as => :ldap_person_search
    
    namespace :admin do
      resources :announcements
      resources :users
    end
  end
  
end
