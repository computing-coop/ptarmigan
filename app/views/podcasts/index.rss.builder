xml.instruct! :xml, :version=>"1.0"
xml.rss :version=>"2.0", "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd" do
  xml.channel do
    xml.title "Ptarmigan podcasts" 
    xml.description "Recordings from various events at Ptarmigan project space in Tallinn, Estonia, both current and archival."
    xml.link 'http://ptarmigan.ee/podcasts'
    xml.language 'en-us'
    xml.tag! "itunes:author", "Ptarmigan project space"
    xml.tag! "itunes:subtitle", "Recordings from Ptarmigan project space, Tallinn, Estonia"
    xml.tag! "itunes:summary", "Recordings from various events at Ptarmigan project space in Tallinn, Estonia, both current and archival."
    xml.tag! "itunes:owner" do
      xml.tag! "itunes:name", "Ptarmigan project space"
      xml.tag! "itunes:email", "info@ptarmigan.ee"    
    end
    xml.tag! "itunes:category", :text => "Arts" do
      xml.tag! "itunes:category", :text => "Performing Arts"
    end    
    xml.tag! "itunes:explicit", "No"
    xml.tag! "itunes:image", :href => "http://ptarmigan.ee/ptarmigan_two_circles.jpg"

    @podcasts.each do |podcast|
      xml.item do  
        xml.title "##{podcast.number}: #{podcast.name}"
        xml.tag! "itunes:author", "Ptarmigan project space"
        xml.tag! "itunes:summary", podcast.description
        xml.tag! "itunes:image", :href => "http://ptarmigan.ee/ptarmigan_two_circles.jpg"
        xml.description podcast.description
        xml.pubDate podcast.created_at.localtime.to_s(:rfc822)
        xml.link podcast_url(podcast)
        xml.guid podcast_url(podcast)
        xml.category "Podcasts"
        xml.enclosure(:url => "http://assets.ptarmigan.ee/#{podcast.cloudfront_filename}", 
        :length => podcast.file_length, :type => "audio/x-m4a" )
      end
    end
  end
end