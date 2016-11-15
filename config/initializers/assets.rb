Rails.application.config.assets.paths << Rails.root.join("app", "assets", "themes", "creativeterritories", "fonts")
Rails.application.config.assets.precompile += %w( ckeditor/* creativeterritories/stylesheets/staff.css creativeterritories/javascripts/staff.css creativeterritories/fonts/*)
