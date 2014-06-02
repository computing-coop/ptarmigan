

# index.rss.builder
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Ptarmigan"
    xml.description "Ptarmigan [Helsinki + Tallinn] feed"
    xml.link 'http://ptarmigan.ee/feed.rss'
    
    for event in @feed
      xml.item do
        xml.title event.class.to_s + ": " + event.title
        xml.description ( event.location == true  ? "<p>[" + event.location.name + "]</p>" : '' ) +  event.rss_description(I18n.locale.to_s)
        xml.pubDate event.created_at.to_s(:rfc822)
        if event.class == Podcast
          xml.link podcast_url(event)
          xml.guid podcast_url(event)
          xml.category "Podcasts"
          xml.enclosure(:url => "http://assets.ptarmigan.ee/#{event.cloudfront_filename}", 
          :length => event.file_length, :type => "audio/x-m4a" )
        else
          xml.link url_for(:controller => event.class.to_s.tableize, :action => :show, :id => event.slug, :host => (event.subsite ? event.subsite.name + "." : '') + "ptarmigan." + (event.subsite == true ? event.subsite.location.locale : event.location.locale) )
          xml.guid url_for(:controller => event.class.to_s.tableize, :action => :show, :id => event.slug, :host => (event.subsite ? event.subsite.name + "." : '') + "ptarmigan." + (event.subsite == true ? event.subsite.location.locale : event.location.locale) )
        end
      end
    end
  end
end

