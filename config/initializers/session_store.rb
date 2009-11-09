# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails_webroot_session',
  :secret      => '6406350bce25bb3f3a9e12c7a12497e5c0577de0aca15faf08ee39df2a50078441f31e1b0439097dad5515571b2955c5ff0b4a6697855d69c1657f0756554def'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
