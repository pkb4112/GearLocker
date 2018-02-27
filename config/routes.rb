Rails.application.routes.draw do
	
  resources :items do 
  	collection do 
  		get 'checked_out'
      get 'available_items' 
  	end
  end

  resources :categories

  resources :members do 
      get 'checkout', on: :member #This is the rails member, not UCOC Member
      post 'checkout', to: "items#checkout_item", on: :member
  		get 'items', on: :member 
  	end

     
 

  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
