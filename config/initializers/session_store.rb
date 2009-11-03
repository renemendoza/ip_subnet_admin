# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_administrador_ips_session',
  :secret      => 'c0bc0ddee0ea04dc1ee05ff73f1c315cfa2ed03b18b39efb5954d14270a9af747b3ef6aa80c698a244710783c29b4fa4790aa55cb8c50318e4e59b7314f4d882'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
