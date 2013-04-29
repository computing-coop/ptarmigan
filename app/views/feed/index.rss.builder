

# index.rss.builder
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Ptarmigan"
    xml.description "Ptarmigan [Helsinki + Tallinn] feed"
    xml.link events_path(:rss)
    
    for event in @feed
      xml.item do
        xml.title event.title
        xml.description "<p>[" + event.location.name + "]</p>" +  event.rss_description(I18n.locale.to_s)
        xml.pubDate event.feed_date.to_s(:rfc822)
        xml.link event_url(:id => event.id)
        xml.guid event_url(:id => event.id, :format => :rss)
      end
    end
  end
end

