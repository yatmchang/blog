Rails.application.routes.draw do
  get  "/about" => "about#index"
  get "/password" => "users#password_edit", as: :password_edit
  patch "/password" => "users#password_update", as: :password_update

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :users, only: [:new, :create, :edit, :update, :show]
  resources :posts do
    get :search, on: :collection

    post :flag, on: :member

    post :mark_done

    resources :comments, only: [:create, :destroy]
    resources :favourites, only: [:create, :destroy]
  end

  resources :favourites, only: [:index]
  resources :password_resets
  root "home#index"
end
