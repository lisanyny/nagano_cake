Rails.application.routes.draw do
  # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: "homes#top"

    get "orders/complete" => "orders#complete"
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    post "orders/confirm" => "orders#confirm"
    resources :orders, only: [:new, :create, :index, :show]
    resources :cart_items, only: [:index, :update, :create]
    delete "cart_items/delete_all", to: "cart_items#delete_all", as: "delete_all_cart_item"
    delete "cart_items/:id", to: "cart_items#destroy", as: "destroy_cart_item"
    resources :items, only: [:index, :show]

    get "/about", to: "homes#about", as: "about"
    get "customers/my_page", to: "customers#show", as: "my_page"
    get "customers/information/edit", to: "customers#edit", as: "edit_information"
    patch "customers/information", to: "customers#update", as: "update_information"
    get "customers/confirm", to: "customers#confirm", as: "confirm"
    patch "customers/thanks", to: "customers#thanks", as: "thanks"
  end

  namespace :admin do
    root to: "homes#top"

    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
