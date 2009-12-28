set :application, "dobre-gostilne.si"
set :domain, "staging-staging"
set :deploy_to, "/webroot/gostilne"
set :repository, 'git@home:gostilne.git'
set :scm, 'git'

namespace :vlad do
  
  desc "Symlinks stuff"
  remote_task :symlink do
    cmd = ""
    puts "Linking shared stuff to current release..."
    [
      ["#{shared_path}/database.yml", "#{current_release}/config"],
      ["#{shared_path}/assets", "#{current_release}/public/assets"],
      ["#{shared_path}/gmaps.rb", "#{current_release}/config/initializers/gmaps.rb"]
    ].each do |link|
      cmd += "ln -s #{link[0]} #{link[1]}; "
    end
    run cmd
  end

  remote_task :update do 
    Rake::Task['vlad:symlink'].invoke
  end
  
  desc "Deploy application"
  remote_task :deploy do 
    system("git push")    
    Rake::Task['vlad:update'].invoke
    Rake::Task['vlad:migrate'].invoke
    Rake::Task['vlad:start_app'].invoke
  end
  
  desc "Maintenance ON"
  remote_task :mon do
    puts "MAINTENANCE !!!"
    run "cp #{current_release}/public/maintenance_.html #{current_release}/public/maintenance.html"
  end
  
  desc "Maintenance OFF"
  remote_task :moff do
    puts "MAINTENANCE OFF ..."
    run "rm #{current_release}/public/maintenance.html"
  end
  
  desc "Cleanup SASS/JS/cache leftovers"
  remote_task :cleanup_sass do
    puts "Cleaning up SASS leftovers..."
    run "rm -f #{current_release}/public/stylesheets/*.css; rm -f #{current_release}/public/javascripts/all.js;"
  end
  
  remote_task :start_app => :cleanup_sass
end