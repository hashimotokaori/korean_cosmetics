Rails.application.routes.draw do
  # namespace :public do
  #   get 'posts/show'
  #   get 'cosmetics/index'
  #   get 'cosmetics/show'
  # end
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
  get "/" => "customers#index"
  resources :customers, only: [:index, :show, :edit, :update]
  resources :posts, only: [:index, :show, :update]
  # resources :items, only: [:index, :create, :new, :show, :edit, :update]

    # get "/search" => "items#search"
  end
  
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
devise_scope :customer do
  post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
end
  scope module: :public do
    root "homes#top"
    resource :customers, only: [:show, :update]
    
    get 'posts/update_review/:id' => "posts#update_review", as: 'post_update_review'
    resources :posts, only: [:new, :create, :index, :show, :destroy, :update] do
      resources :post_comments, only: [:create, :destroy]
    end
    
    get 'cosmetics/new'
    get 'cosmetics/index'
    get 'cosmetics/search'
    get 'cosmetics/:id' => "cosmetics#show"
  
    resource :customers, only: [:show, :edit]
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
