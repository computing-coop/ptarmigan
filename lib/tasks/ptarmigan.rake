require 'open-uri'
require 'flickraw'
def grabURL(url, home)
  require 'open-uri'
  open(home,"w").write(open(url).read)
end

namespace :ptarmigan do
  desc "Make local images from flickr"
  task :get_flickrs => [:environment] do
    Flicker.where(:image_file_name => nil).each do |image|
      system('mkdir -p ' + Rails.root.to_s + "/public/images/contrib/#{image.id}/cropped")
      system('mkdir -p ' + Rails.root.to_s + "/public/images/contrib/#{image.id}/standard")
      system('mkdir -p ' + Rails.root.to_s + "/public/images/contrib/#{image.id}/medium")
      system('mkdir -p ' + Rails.root.to_s + "/public/images/contrib/#{image.id}/front_sidebar")
      system('mkdir -p ' + Rails.root.to_s + "/public/images/contrib/#{image.id}/original")
      info = flickr.photos.getSizes(:photo_id => image.hostid)
      url =  info.find{|x| x.label == 'Large' }
      if url.nil?
        url =  info.find{|x| x.label == 'Original' }
        if url.nil?
          url =  info.find{|x| x.label == 'Medium' }
          if url.nil?
            puts "still can't access " + image.hostid
            next
          else
            url = url['source']
          end
        else
          url = url['source']
        end
      else
        url = url['source']
      end
      begin
        filename = url.match(/([^\/]+)(\?.+)*$/)[1]
        dest = Rails.root.to_s + "/public/images/contrib/#{image.id}/original/#{filename}"
        grabURL(url, dest) 
        rescue 
          puts "can't get " + url + " to dest " + dest
          next
        end

      image.image_file_name = filename
      if filename =~ /jpg$/i 
        content_type = 'image/jpeg'
      elsif filename =~ /png$/i
        content_type = 'image/png'
      elsif filename =~ /gif$/i
        content_type = 'image/gif'
      else
        content_type = 'unknown'
      end
      
      image.image_file_size = File.stat(Rails.root.to_s + "/public/images/contrib/#{image.id}/original/#{filename}").size
      next if image.image_file_size == 0
      image.image_content_type = content_type
      image.image_updated_at = File.stat(Rails.root.to_s + "/public/images/contrib/#{image.id}/original/#{filename}").mtime
      image.save!
    end
    
  end
end