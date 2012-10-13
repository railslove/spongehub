Rumble12::Application.routes.draw do
  get "pages/homepage"
  get "pages/about"

  resources :spaces do
    # Your routes go here!
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'pages#homepage'
end
