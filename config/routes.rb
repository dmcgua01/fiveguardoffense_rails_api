Rails.application.routes.draw do
  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    post "login", to: "login#login"
    resources :users, only: %i(create show update destroy)
  end
end
