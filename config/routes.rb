Rails.application.routes.draw do
  get  "/about" => "about#index"
  resources :posts do
    get :search, on: :collection

    post :flag, on: :member

    post :mark_done

    resources :comments, only: [:create, :destroy]
  end

  root "home#index"
end
