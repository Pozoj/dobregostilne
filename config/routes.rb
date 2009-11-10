ActionController::Routing::Routes.draw do |map|
  map.resources :images, :spot_infos, :orders, :payments, :types, :cuisines, :posts
  map.resources :localities do |locality|
    locality.resources :spots
  end
  map.root :controller => :localities
end
