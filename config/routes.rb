Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home" # トップページ

  # ログイン，サインイン
  get  '/signup',  to: 'shops#new'
  post '/signup',  to: 'shops#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :items
  resources :shops
  post "/items/:id", to: "items#update" # 外部からupdate出来るようにpostを追加(PUTは弾かれるため)
  get "/search", to: "items#search" # インクリメンタルサーチ用
end
