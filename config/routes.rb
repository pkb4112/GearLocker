Rails.application.routes.draw do
	
  resources :items
  resources :categories
  resources :members
  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
