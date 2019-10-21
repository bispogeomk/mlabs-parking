Rails.application.routes.draw do
  get "parking/:plate", to: "parking#historic"
  resources :parking do
    get "pay", to: "parking#pay"
    get "out", to: "parking#out"
  end
end
