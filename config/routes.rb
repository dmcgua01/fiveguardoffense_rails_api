Rails.application.routes.draw do
  post "login", to: "login#login"
  resources :users, only: %i(create show update destroy)
end
