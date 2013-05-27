Rails.application.routes.draw do
  root to: 'ucb_rails/home#index'
  
  match 'ucb_rails', :to => 'ucb_rails/home#index'
  
  match '/login', :to => 'ucb_rails/sessions#new', :as => 'login'
  match '/logout', :to => 'ucb_rails/sessions#destroy', :as => 'logout'
  match '/auth/:provider/callback' => 'ucb_rails/sessions#create'
  match '/auth/failure' => "ucb_rails/sessions#failure"
  
end
