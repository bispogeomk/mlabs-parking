Rails.application.routes.draw do
  resources :parking do
    resources :pay, only: :show
    resources :out, only: :show
  end
end
