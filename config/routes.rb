Rails.application.routes.draw do

#認証機能に関して
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions',
    passwords: 'admins/passwords'
  }
  devise_for :customers, controllers: {
    registrations: 'publics/registrations',
    sessions: 'publics/sessions',
    passwords: 'publics/passwords'
  }


  namespace :public do
    get "/top"=> "homes#top"
    root to: 'homes#top' 
    get 'homes/about' => 'homes#about'
  	resources :customers, only: [:index, :show, :new, :edit, :create, :update, :destroy]
      get "customers/:id/check" => "customers#check"
      patch "customers/:id/check" => "customers#withdrow"
      #退会ページのルート
    resources :items, only: [:index, :show]
    resources :orders, only: [:index, :show, :new, :confirm, :thanks, :create] do
          collection do
      post :confirm
    end
  end
    resources :deliveries, only: [:index, :edit, :update, :create, :destroy]
    resources :cart_items, only: [:index, :create, :destroy, :update, :destroy_all]
    resources :order_items, only: [:index]
  end

  namespace :admin do
  	get "/top"=> "homes#top"
    root to: 'homes#top'
  	resources :customers, only: [:index, :edit, :update]
  	resources :admins, only: [:show]
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    resources :orders, only: [:index, :show, :create, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :order_items, only: [:index, :create, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
