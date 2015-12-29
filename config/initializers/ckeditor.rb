# -*- encoding : utf-8 -*-
# Use this hook to configure ckeditor
if Object.const_defined?("Ckeditor")

  Ckeditor.setup do |config|
    require "ckeditor/orm/active_record"
    config.assets_languages = ['en', 'fi', 'sv']
    config.assets_plugins = ['image', 'filebrowser', 'link']
  end
end
