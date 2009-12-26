ActionController::Routing::Routes.draw do |map|
  map.resources :orders, :payments, :types, :cuisines, :posts
  map.resources :localities do |locality|
    locality.resources :spots
  end
  map.resources :spots do |spot|
    spot.resources :infos, :controller => :spot_infos
    spot.resources :spot_infos
    spot.resources :images
  end
  map.root :controller => :localities
end
