Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "articles#index"

  # get "/articles", to: "articles#index"

  # get "/articles/:id/show",      to: "articles#show"
  # post "/articles/:id/edit",     to: "articles#edit"
  post '/articles/uploadFile',   to: "articles#uploadFile"
  post '/articles/downloadFile', to: "articles#downloadFile"

  get '/articles/test' => "/articles/test"

  resources :articles do
    collection {post :import}
  end
end
