Rails.application.routes.draw do

  get "search" => "searches#search", as: "search"

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'
    resources :items, only: [:index,:show]

    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'

    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: "cart_items_destroy_all"
    resources :cart_items, only: [:index,:update,:destroy,:create]

    get '/genre/search/:id' => 'genres#genre_search', as: "public_genre_search"

    get 'orders/thanks' => 'orders#thanks', as: "thanks_order"
    resources :orders, only: [:new,:create,:index,:show]
    post 'orders/confirm' => 'orders#confirm'


    resources :addresses, only: [:index,:edit,:create,:update,:destroy]
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "homes#top"
    resources :items, only: [:index,:new,:create,:show,:edit,:update]
    resources :genres, only: [:index,:create,:edit,:update]
    resources :customers, only: [:index,:show,:edit,:update]
    get 'customer/orders/:id' => 'orders#customer_search', as: "orders_search"
    resources :orders, only: [:index,:show,:update]
    resources :order_details, only: [:update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
