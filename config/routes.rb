ActionController::Routing::Routes.draw do |map|
  map.filter 'locale'
  
  map.resources :orders, :payments, :types, :cuisines, :localities, :posts
  
  # Spots in an area
  map.in_area_spots '/spots_in_area', :controller => :spots, :action => :in_area
  
  # Spots and dependencies
  map.resources :spots do |spot|
    spot.resources :infos, :controller => :spot_infos
    spot.resources :spot_infos
    spot.resources :images, :shallow => true
    spot.resources :payments, :shallow => true
  end
  
  # Search
  map.search '/search.:format', :controller => :spots, :action => :search
  
  # Static content
  map.with_options :controller => :pages do |page|
    page.order "/order", :action => :order
    page.contact "/contact", :action => :contact
    page.authors "/authors", :action => :authors
    page.about "/about", :action => :about
  end
  
  # Root
  map.root :controller => :spots
end
