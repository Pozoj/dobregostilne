RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "paperclip"
  config.gem "geokit"
  config.gem "RedCloth"
  config.gem "will_paginate"
  config.gem 'resource_controller'
  config.gem 'hoptoad_notifier'
  config.time_zone = 'Ljubljana'
  config.i18n.default_locale = :sl
end

# Paperclip hax
if Rails.env.development?
  Paperclip.options[:image_magick_path] = '/usr/local/bin/' 
end


# Initialize route filtering.
require "#{Rails.root}/lib/routing.rb"