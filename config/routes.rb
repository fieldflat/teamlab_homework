Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"

  resources :items
  post "/items/:id", to: "items#update" # 外部からupdate出来るようにpostを追加(PUTは弾かれるため)
  post "/search", to: "items#search"
  get "/search", to: "items#index"
end
