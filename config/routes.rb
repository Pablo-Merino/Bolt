Bolt::Application.routes.draw do


  

	devise_for :users, :controllers => {:registrations => "registrations"}

	resources :statuses, :only => [:create]

	get '/status/:id' => 'statuses/operations#show', :as => 'show_status'

	get '/profile' => 'users/dashboard#index'
	get '/user/:id' => 'users/profile#show', :as => 'user_profile'

	root :to => 'system/static#index'

	put '/user/:id/follow' => 'users/operations#follow', :as => 'follow'
	delete '/user/:id/unfollow' => 'users/operations#unfollow', :as => 'unfollow'

	put '/status/:id/favorite' => 'statuses/operations#favorite', :as => 'favorite_status'
	delete '/status/:id/unfavorite' => 'statuses/operations#unfavorite', :as => 'unfavorite_status'
	delete '/status/:id/delete' => 'statuses/operations#destroy', :as => 'destroy_status'

	get '/timeline' => 'system/timeline#index', :as => 'timeline'
	get '/mentions' => 'system/mentions#index', :as => 'mentions'
	get '/global' => 'system/global#index', :as => 'global'

	get '/about' => 'system/static#about', :as => 'about'

	get '/settings' => 'users/settings#index', :as => 'settings'
	put '/settings' => 'users/settings#update', :as => 'update_settings'

	match '/api/v1' => Api::Core, :anchor => false

	get '/api' => 'system/static#api', :as => 'api_docs'

	get '/admin' => 'system/admin#index', :as => 'admin_panel'
	put '/admin/regenerate' => 'system/admin#regen', :as => 'update_invite_code'

	put '/search' => 'statuses/search#gateway', :as => 'put_search'
	get '/search/:search' => 'statuses/search#show', :as => 'search'

end
