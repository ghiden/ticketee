Ticketee::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }

  get '/awaiting_confirmation', :to => "users#confirmation", 
    :as => 'confirm_user'

  resources :projects do
    resources :tickets
  end

  resources :tickets do
    resources :comments
  end

  resources :files

  root :to => 'projects#index'

  put '/admin/users/:user_id/permissions',
    :to => 'admin/permissions#update',
    :as => :update_user_permissions
  
  namespace :admin do
    root :to => "base#index"
    resources :users do
      resources :permissions
    end
    resources :states 
  end
end
