require 'open-uri'
require 'flickraw'

def strip_emoji ( str )
    str = str.force_encoding('utf-8').encode
    clean_text = ""

    # emoticons  1F601 - 1F64F
    regex = /[\u{1f600}-\u{1f64f}]/
    clean_text = str.gsub regex, ''

    #dingbats 2702 - 27B0
    regex = /[\u{2702}-\u{27b0}]/
    clean_text = clean_text.gsub regex, ''

    # transport/map symbols
    regex = /[\u{1f680}-\u{1f6ff}]/
    clean_text = clean_text.gsub regex, ''

    # enclosed chars  24C2 - 1F251
    regex = /[\u{24C2}-\u{1F251}]/
    clean_text = clean_text.gsub regex, ''

    # symbols & pics
    regex = /[\u{1f300}-\u{1f5ff}]/
    clean_text = clean_text.gsub regex, ''
end

def grabURL(url, home)
  require 'open-uri'
  open(home,"w").write(open(url).read)
end


namespace :madhouse do
  desc "Get superfeed"
  task :get_feed => [:environment] do

    # start with Twitter
    now = Time.now.to_i
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Figaro.env.madhouse_twitter_client_id
      config.consumer_secret     = Figaro.env.madhouse_twitter_client_secret
      config.access_token        = Figaro.env.madhouse_twitter_access_token
      config.access_token_secret = Figaro.env.madhouse_twitter_access_secret
    end  

        
    begin
      tweets = twitter_client.user_timeline("madhousehel")
      tweets.each do |tweet|
        Cash.where(location_id: 4, source: 'twitter',  issued_at: tweet.created_at.to_i, sourceid: tweet.id, title: tweet.text, content: tweet.text, link_url: tweet.uri.to_s).first_or_create
      end

    rescue Twitter::Error::NotFound
      # do nothing if twitter isn't connecting
    end  
  
  
  
    # instagram ?
    
    require 'open-uri'
    require 'json'
    remove_emojis = /[\u{1F600}-\u{1F6FF}]/
    

    begin
      instagram = JSON.parse(open("https://www.instagram.com/madhousehelsinki/media/").read)
      instagram['items'].each do |item|
        c = Cash.where(location_id: 4, source: 'instagram',  issued_at: item["created_time"], sourceid: item["id"], 
                    title: strip_emoji(item["caption"]["text"]), link_url: item["link"]).first_or_create
        unless c.image?
          c.image = URI.parse(item["images"]["standard_resolution"]["url"])
          c.save
        end
      end
    rescue
    end
    
    # facebook ?
    begin
      
      @oauth = Koala::Facebook::OAuth.new(Figaro.env.madhouse_facebook_client_id, Figaro.env.madhouse_facebook_client_secret)
      @access_token = @oauth.get_app_access_token
      @graph = Koala::Facebook::API.new(@access_token)
      posts = @graph.get_connection('madhousehelsinki', 'posts',
                      {limit: 30,
                        fields: ['message', 'id', 'from', 'type',
                                  'picture', 'link', 'created_time', 'updated_time'
                          ]})

      done = []
    
      posts.each do |post|
        if post['id'] =~ /\_/
          pid = post['id'].match(/([0-9])\_(\d*)/)[2]
        else
          pid = post['id']
        end
      
        next if Cash.exists?(source: 'facebook', sourceid: pid) || done.include?(pid)
        # get attachments
        moreinfo = @graph.get_connections(post['id'], 'attachments').first
        c = Cash.where(location_id: 4, source: 'facebook',  issued_at: post["created_time"].to_time.to_i, sourceid: pid, 
                      title: strip_emoji(moreinfo['description'].to_s), link_url: post["link"]).first_or_create
        unless c.image?
          unless moreinfo['media']['image']['src'].nil?
            c.image = URI.parse(moreinfo['media']['image']['src'])
            c.save
          end
        end
        done.push(pid)
      end  
    rescue
    end
  end
  
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