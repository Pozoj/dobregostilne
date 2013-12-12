RAILS_GEM_VERSION = '2.3.18' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'Ljubljana'
  config.i18n.default_locale = :sl
end

# Paperclip hax
if Rails.env.development?
  Paperclip.options[:image_magick_path] = '/usr/local/bin/' 
end

# Initialize route filtering.
require "#{Rails.root}/lib/routing.rb"