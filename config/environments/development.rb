# -*- encoding : utf-8 -*-
Ptarmigan::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  # config.action_controller.perform_caching = false

  config.action_controller.perform_caching = true
  config.cache_store = :redis_store


  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  config.active_record.raise_in_transactional_callbacks = true

  # Raise exception on mass assignment protection for Active Record models
  config.eager_load = false

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)

  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.assets.compress = false
  config.serve_static_files = true
  # Expands the lines which load the assets
  config.assets.debug = false
  config.action_controller.asset_host = Proc.new { |source|
   if source.starts_with?('/images')  || source.starts_with?('/system/icons')
     "http://ptarmigan.fi"
   else
     "http://localhost:3000"
   end
 }
 config.paperclip_defaults = {
   :storage => :s3,
   :bucket => 'creativeterritories-production'
 }
 config.middleware.insert_before 0, "Rack::Cors" do
    allow do
      origins '*'
      resource '*', :headers => :any, :methods => [:get, :post, :options]
    end
  end
 
 
end

