Rails.application.routes.draw do

  devise_for :customers
  devise_for :admins


  namespace :public do
    get "/top"=> "home#top"
    root 'home#top'
    get 'home/about' => 'home#about'
    post 'order/confirm'=> "order#confirm"
    get 'order/thanks'=> "order#thanks"
  	resources :customers, only: [:index, :show, :new, :edit, :create, :update, :destroy, :check, :withdrow]
    resources :items, only: [:index, :show]
    resources :orders, only: [:index, :show, :new, :confirm, :thanks, :create]
    resources :deliveries, only: [:index, :edit, :update, :create, :destroy]
    resources :cart_items, only: [:index, :create, :destroy, :update, :destroy_all]
    resources :order_items, only: [:index]
  end

  namespace :admin do
  	get "/top"=> "home#top"
  	resources :customers, only: [:index, :edit, :update]
  	resources :admins, only: [:show]
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    resources :orders, only: [:index, :show, :create, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :order_items, only: [:index, :create, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
