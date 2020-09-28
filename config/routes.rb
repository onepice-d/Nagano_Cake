Rails.application.routes.draw do
root 'public/homes#top'
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
    get 'orders/thanks' => 'orders#thanks'
  	resources :customers, only: [:index, :show, :new, :edit, :create, :update, :destroy]
      get "customers/:id/check" => "customers#check"
      patch "customers/:id/check" => "customers#withdrow"
      #退会ページのルート
    resources :items, only: [:index, :show]
    get '/orders/thanks' => 'orders#thanks'
    get '/orders/confirm' => 'orders#confirm'
    resources :orders, only: [:index, :show, :new, :confirm, :thanks, :create] do
          collection do
      post :confirm
    end
  end
    resources :deliveries, only: [:index, :edit, :update, :create, :destroy]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :create, :destroy, :update]do
      collection do
        post :next
        post :confirm
      end
    end
    resources :order_items, only: [:index]
    resources :genres, only: [:show]
  end

  namespace :admin do
  	get "/top"=> "homes#top"
    root to: 'homes#top'
  	resources :customers, only: [:index, :edit, :update, :show]
  	resources :admins, only: [:show]
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    resources :orders, only: [:index, :show, :create, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :order_items, only: [:index, :create, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
