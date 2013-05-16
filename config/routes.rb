Sentrino::Application.routes.draw do
 
	root :to => "home#index"

  match '/users/:user_id/tasks/home' => 'tasks#home'

  devise_for :users, :path => 'accounts', :skip => [:sessions]
  as :user do
    get 'sign_in' => 'devise/sessions#new', :as => :new_user_session
    post 'sign_in' => 'devise/sessions#create', :as => :user_session
    get 'sign_up' => 'devise/registrations#new', :as => :new_user_session
    delete 'sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :index
  resources :application
  
  resources :devices do
    resources :actions
    resources :sensors
  end

  resources :users do
    resources :tasks
  end

  match '/settings' => 'home#settings'
  match "/runcron" => "tasks#cron"

  #match '/dashboard' => 'home#dashboard', :as => 'user_root'

end
