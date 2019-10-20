Rails.application.routes.draw do
  resources :parking do
    get "pay", to: "parking#pay"
    get "out", to: "parking#out"
    # resources :pay, only: :show
    # resources :out, only: :show
  end
end
