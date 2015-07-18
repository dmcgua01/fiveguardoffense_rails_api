Rails.application.routes.draw do
  post "login", to: "login#login"
  resources :users
end
