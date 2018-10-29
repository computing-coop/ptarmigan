# -*- encoding : utf-8 -*-
Ptarmigan::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true
  config.eager_load = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  # config.active_record.raise_in_transactional_callbacks  = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false
  config.force_ssl = true
  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX
  config.log_level = :error
  #
  # config.cache_store = :dalli_store
  # config.action_dispatch.rack_cache = {
  #                       :metastore    => Dalli::Client.new,
  #                       :entitystore  => 'file:tmp/cache/rack/body',
  #                       :allow_reload => false }
  # config.static_cache_control = "public, max-age=2592000"
  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"
  config.action_mailer.perform_caching = false
  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!
  config.paperclip_defaults = {
    :storage => :s3,
    s3_credentials: {
     bucket: 'creativeterritories-production',
     s3_region: 'us-east-1',
     access_key_id:  ENV.fetch('WASABI_ACCESS_KEY'),
       secret_access_key: ENV.fetch('WASABI_SECRET'),
       s3_host_name: "s3.wasabisys.com"  
     },
     s3_options: {
       endpoint: "https://s3.wasabisys.com"
     },
     s3_host_name: 's3.wasabisys.com'
  }

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  # config.i18n.fallbacks = true
  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify
  config.action_mailer.default_url_options = { :host => 'ptarmigan.ee' }
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
ActionMailer::Base.sendmail_settings = {
        location: "/usr/sbin/sendmail",
        arguments: '-i -t'
}

ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default charset: "utf-8"
