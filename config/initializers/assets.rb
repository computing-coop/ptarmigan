Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "fonts")
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "themes", "creativeterritories", "fonts")
Rails.application.config.assets.precompile += %w( ckeditor/* creativeterritories/stylesheets/staff.css creativeterritories/javascripts/staff.css creativeterritories/fonts/*)
Rails.application.config.assets.precompile += %w(ckeditor/config.js madhouse/stylesheets/bad-house.css)

Rails.application.config.assets.precompile += %w( *.woff *.eot *.svg *.ttf)
Rails.application.config.assets.precompile += %w( common.css print.css  jwplayer.js jwplayer.html5.js cms.css cms.js creativeterritories/javascripts/application.js creativeterritories/javascripts/staff.js madhouse/stylesheets/staff.css creativeterritories/stylesheets/application.css madhouse/javascripts/staff.js )

