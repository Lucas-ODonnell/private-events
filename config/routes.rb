Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   
  root 'events#index'

  resources :users
  resources :events

  resources :invitations do
    collection do
      get :edit_all
      put :update_all
    end
  end
end
