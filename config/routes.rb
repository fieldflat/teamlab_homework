Rails.application.routes.draw do
  get 'shops/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home" # トップページ

  resources :items
  post "/items/:id", to: "items#update" # 外部からupdate出来るようにpostを追加(PUTは弾かれるため)
end
