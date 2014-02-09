

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
        xml.description "<p>[" + event.location.name + "]</p>" +  event.rss_description(I18n.locale.to_s)
        xml.pubDate event.created_at.to_s(:rfc822)
        xml.link event_url(:id => event.slug)
        xml.guid url_for(event)
      end
    end
  end
end

