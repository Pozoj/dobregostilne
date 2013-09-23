set :application, "dobre-gostilne.si"
set :domain, "racker-deploy"
set :deploy_to, "/webroot/dobregostilne"
set :repository, 'git@staging:gostilne.git'
set :scm, 'git'

namespace :vlad do
  
  desc "Symlinks stuff"
  remote_task :symlink do
    cmd = ""
    puts "Linking shared stuff to current release..."
    [
      ["#{shared_path}/database.yml", "#{current_release}/config"],
      ["#{shared_path}/assets", "#{current_release}/public/assets"],
      ["#{shared_path}/gmaps.rb", "#{current_release}/config/initializers/gmaps.rb"],
      ["#{shared_path}/rvmrc", "#{latest_release}/.rvmrc"],
      ["#{shared_path}/setup_load_paths.rb", "#{latest_release}/config/setup_load_paths.rb"]
      end
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
    Rake::Task['vlad:notify_hoptoad'].invoke
  end

  task :notify_hoptoad => [:git_user, :git_revision] do
    notify_command = "rake hoptoad:deploy TO=#{rails_env} REVISION=#{current_sha} REPO=#{repository} USER='#{current_user}'" 
    puts "Notifying Hoptoad of Deploy (#{notify_command})" 
    `#{notify_command}`
    puts "Hoptoad Notification Complete."
  end

  remote_task :git_revision do
    set :current_sha, run("cd #{File.join(scm_path, 'repo')}; git rev-parse origin/master").strip
  end

  task :git_user do
    set :current_user, `git config --get user.name`.strip
  end
end
