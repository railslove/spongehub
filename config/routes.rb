Rumble12::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  resources :identities
  get "pages/homepage"
  match "about", to: 'pages#about', as: 'about'

  resources :users

  resources :spaces do
    resources :chores do
      member do
        put :take
        put :done        
      end
    end
    resources :ratings
    resources :users, controller: :space_users, only: [:index, :destroy, :create]
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'pages#homepage'
end
