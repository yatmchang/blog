Rails.application.routes.draw do
  get  "/about" => "about#index"
  resources :users, only: [:new, :create, :edit, :update, :show]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :posts do
    get :search, on: :collection

    post :flag, on: :member

    post :mark_done

    resources :comments, only: [:create, :destroy]
  end

  root "home#index"
end
