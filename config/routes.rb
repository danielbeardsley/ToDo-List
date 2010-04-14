ToDoList::Application.routes.draw do
  match '/' => 'lists#buttons'

  resources :lists do
    resources :items
    resource :current_item do
      post :get
      post :defer
      post :complete
    end
  end

  resources :items do
    member do
      post :complete
    end
  end

  match '/:controller(/:action(/:id))'
end
