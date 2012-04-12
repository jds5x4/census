Census::Engine.routes.draw do

  resources :zebras

  resources :data_groups,
            :except => [:index, :show],
            :collection => {:sort => :put}
  match "admin" => "data_groups#index", :as => :admin
  
end
