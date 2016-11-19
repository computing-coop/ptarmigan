# -*- encoding : utf-8 -*-
# Be sure to restart your server when you modify this file.

# Ptarmigan::Application.config.session_store :cookie_store, key: '_ptarmigan_session'
Ptarmigan::Application.config.session_store :redis_store, servers: "redis://localhost:6379/0/session"
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Ptarmigan::Application.config.session_store :active_record_store
