# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_ToDoList_session',
  :secret => '806364d2419146dd3741d8bcf149dbfd5557d6bea8521abf65594a78740016cba19434a455ab3738712e61b8cbf5daaa4da0ac25bc65a5d1566a2b1cd7dc6dcb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
