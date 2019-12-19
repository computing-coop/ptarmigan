# -*- encoding : utf-8 -*-
# Use this hook to configure ckeditor
# if Object.const_defined?("Ckeditor")

  Ckeditor.setup do |config|
    require "ckeditor/orm/active_record"
    config.cdn_url = '//cdn.ckeditor.com/4.13.0/full/ckeditor.js'
    # config.assets_languages = ['en', 'fi', 'sv']
    # config.assets_plugins = ['image', 'filebrowser', 'link', 'removeformat']
  end
# end
