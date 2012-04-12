Rails.application.routes.draw do

  resources :users

  mount Census::Engine => "/census", :as => 'census'
end
