Rails.application.routes.draw do
  get  "/about" => "about#index"
  # post "/cowsay" => "cowsay#create", as: :cowsay_submit
  root "home#index"
end
