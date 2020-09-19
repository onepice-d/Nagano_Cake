Rails.application.routes.draw do

  devise_for :customers
  devise_for :admins

 
  namespace :public do
    resources :items
  end

  namespace :admin do
    resources :items
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
