require 'progressbar'

namespace :geo do
  
  desc "determines latitude and longitude from address (only spots that are not already geocoded)"
  # precisions: address, street, zip, no
  task :code => [:environment] do
    Location.all.each { |loc| loc.geocode! unless loc.geocoded? }
  end
  
  desc "fetches latitude and longitude from address"
  task :code_force => [:environment] do
    pbar = ProgressBar.new("Geocoding...", Location.count)
    Location.all.each do |loc| 
      loc.geocode!
      pbar.inc
    end
    pbar.finish
  end
  
end