require_relative 'boot'

require 'rails/all'


require 'i18n/backend/fallbacks'

Bundler.require(*Rails.groups)



module Ptarmigan
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.load_defaults 5.1
    config.cache_classes = true
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]
    # config.cache_store = :redis_store, "redis://localhost:6379/0/cache", { expires_in: 2.hours }
    config.cache_store = :mem_cache_store
    # Full error reports are disabled and caching is turned on
    # config.consider_all_requests_local       = false
    # config.action_controller.perform_caching = true

    # Disable Rails's static asset server (Apache or nginx will already do this)
    # config.serve_static_assets = false

    # Compress JavaScripts and CSS
    # config.assets.compress = true
    # config.assets.compile = true

    # Generate digests for assets URLs
    # config.assets.digest = true

    # Specifies the header that your server uses for sending files
    # config.action_dispatch.x_sendfile_header = "X-Sendfile"
    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"
    config.i18n.fallbacks = true

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    # Enable escaping HTML in JSON.

    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql
    # config.active_record.whitelist_attributes = false

    config.i18n.fallbacks = {'lv' => ['en', 'ru'] }


  end
end
