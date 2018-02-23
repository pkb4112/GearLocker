Rails.application.routes.draw do
	
  resources :items do 
  	collection do 
  		get 'checked_out'
  	end
  end
  resources :categories
  resources :members do 
  		get 'items', on: :member #This is the rails member, not UCOC Member
  	end
 

  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
