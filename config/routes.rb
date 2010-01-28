ActionController::Routing::Routes.draw do |map|
  map.resources :orders, :payments, :types, :cuisines
  map.resources :localities, :has_many => :spots
  map.resources :posts, :has_many => :spots
  map.resources :spots do |spot|
    spot.resources :infos, :controller => :spot_infos
    spot.resources :spot_infos
    spot.resources :images
    spot.resources :payments
  end
  map.root :controller => :localities
end
