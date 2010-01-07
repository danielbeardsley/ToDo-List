# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ToDoList_session',
  :secret      => '021c089be0154ac1fc79ae2ecbb3e04bf49bb12d3e011bbb3db53b259ae08a090faf5d76184538dd18ffae2d7afd51fdf3bff2349c2aac93d7d54bc638d00607'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
