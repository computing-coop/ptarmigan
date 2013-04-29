

# index.rss.builder
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Ptarmigan"
    xml.description "Ptarmigan events"
    xml.link events_path(:rss)
    
    for event in @events
      xml.item do
        xml.title event.title
        xml.description event.description(I18n.locale.to_s)
        xml.pubDate event.created_at.to_s(:rfc822)
        xml.link event_url(:id => event.id, :format => :rss)
        xml.guid event_url(:id => event.id, :format => :rss)
      end
    end
  end
end

