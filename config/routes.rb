Rails.application.routes.draw do


  #顧客用
  devise_for :customers,skip: [:passwords], controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #管理者用
  devise_for :admin,skip: [:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: 'homes#top'

    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
    resources :orders, only:[:new, :confirm, :complete, :create, :index, :show]
    resources :cart_items, only:[:index, :update, :destroy, :delete_all, :create]
    resource :customers, only:[:show, :edit, :update, :confirm, :thanks]
    resources :items, only:[:index, :show]

    get 'home/about', to: 'homes#about', as: 'about'
  end

  namespace :admin do
    root to: 'homes#top'

    resources :orders, only:[:show, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
