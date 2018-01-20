Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'

  get 'pages/home', to: 'pages#home'

  resources :recipes do
    resources :comments, only: [:create] # creates a route to receive new comment submissions for a given recipe.
  end
  # get 'recipes', to: 'recipes#index'
  # get 'recipes/new', to: 'recipes#new', as: 'new_recipe'
  # get 'recipes/:id', to: 'recipes#show', as: 'recipe'
  # post 'recipes', to: 'recipes#create'

  resources :chefs, except: [:new]

  resources :ingredients, except: [:destroy]

  get 'signup', to: 'chefs#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
