class CorrectInlineImages < ActiveRecord::Migration[5.0]
  def change
    PublicActivity.enabled = false
    ActiveRecord::Base.record_timestamps = false
    Post.all.each do |p|
      p.translations.each do |pp|
        next if pp.body.nil?
        pp.body.gsub!(/\"\/ckeditor_assets/, '"http://creativeterritories-production.s3.amazonaws.com/ckeditor_assets')
        pp.body.gsub!(/\"http:\/\/ptarmigan\.(\w\w)\/ckeditor_assets/, '"http://creativeterritories-production.s3.amazonaws.com/ckeditor_assets')
      end
      p.save(validate: false)
    end
    Artist.all.each do |p|
      p.translations.each do |pp|
        next if pp.bio.nil?
        pp.bio.gsub!(/\"\/ckeditor_assets/, '"http://creativeterritories-production.s3.amazonaws.com/ckeditor_assets')
        pp.bio.gsub!(/\"http:\/\/ptarmigan\.(\w\w)\/ckeditor_assets/, '"http://creativeterritories-production.s3.amazonaws.com/ckeditor_assets')
      end
      p.save(validate: false)
    end
    Project.all.each do |p|
      p.translations.each do |pp|
        next if pp.description.nil?
        pp.description.gsub!(/\"\/ckeditor_assets/, '"http://creativeterritories-production.s3.amazonaws.com/ckeditor_assets')
        pp.description.gsub!(/\"http:\/\/ptarmigan\.(\w\w)\/ckeditor_assets/, '"http://creativeterritories-production.s3.amazonaws.com/ckeditor_assets')
      end
      p.save(validate: false)
    end
    Event.all.each do |p|
      p.translations.each do |pp|
        next if pp.description.nil?
        pp.description.gsub!(/\"\/ckeditor_assets/, '"http://creativeterritories-production.s3.amazonaws.com/ckeditor_assets')
        pp.description.gsub!(/\"http:\/\/ptarmigan\.(\w\w)\/ckeditor_assets/, '"http://creativeterritories-production.s3.amazonaws.com/ckeditor_assets')

      end
      p.save(validate: false)
    end    
    PublicActivity.enabled = true
    ActiveRecord::Base.record_timestamps = true
  end
end
