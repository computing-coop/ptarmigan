# -*- encoding : utf-8 -*-

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  
  def awesome_truncate(text, length = 30, truncate_string = "...")
    return if text.nil?
    l = length - 3
    text.gsub(/<\/?[^>]*>/,  "").length > length ? text.gsub(/<\/?[^>]*>/,  " ")[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m]  + truncate_string : text
  end

  def calendar_circles(arry)
    h = "_"
    e = "_"
    t = "_"
    s = "_"
    arry.uniq.each do |x|
      if x == 1
        h = "h"
      end
      if x == 2
        e = "e"
      end
      if x == 'Event' || x == 'Show'
        t = "t"
      end
      if x == 'Scorestore'
        s = "s"
      end
    end
    return h + e + t + s
  end


def date_range(from_date, until_date, options = {})
    options.symbolize_keys!
    format = options[:format] || :short
    separator = options[:separator] || "—"

    if format.to_sym == :short
      month_names = I18n.t("date.abbr_month_names")
    else
      month_names = I18n.t("date.month_names")
    end

    from_day = from_date.day
    from_month = month_names[from_date.month]
    from_year = from_date.year
    until_day = until_date.day

    if from_date.month == until_date.month
      I18n.t("date_range.#{format}.same_month", from_day: from_date.day, until_day: until_date.day, month: from_month, year: from_year, sep: separator)
    else
      until_month = month_names[until_date.month]
      if from_date.year == until_date.year
        I18n.t("date_range.#{format}.different_months_same_year", from_day: from_date.day, from_month: from_month, until_day: until_date.day, until_month: until_month, year: from_year, sep: separator)
      else
        until_year = until_date.year
        I18n.t("date_range.#{format}.different_years", from_day: from_date.day, from_month: from_month, from_year: from_year, until_day: until_date.day, until_month: until_month, until_year: until_year, sep: separator)
      end
    end
  end
  
 
  def event_calendar
    lambda do |day|
      unless Event.has_events_on(day).blank?
        [link_to(day.day, event_url(:id => day.to_s)), { :class => "dayWithEvents" }]
      else
        day.day
      end
    end
  end
  
  def event_name(event)
    if event.nil?
      return ""
    else
      return event.title
    end
  end
  
  def facebook_link(event, front = true)
    
    if front == false
      width = 20
    else
      width = 30
    end

    
    if event.publicschool.blank?
      out = ''
    else
      out = link_to(image_tag('layout/tps.png', {:alt => 'Public School Helsinki class page', :border => 0, :width => width}), 'http://helsinki.thepublicschool.org/class/' + event.publicschool.to_s)
    end
    
    
    if event.facebook.blank?
      out += ""
    else
      out += link_to(image_tag('layout/facebook.png', {:alt => 'facebook event', :border => 0, :width => width}), 'http://www.facebook.com/event.php?eid=' + event.facebook.to_s)
    end
    
    if event.videos.empty?
      out += ''
    else
      out += link_to(image_tag('layout/vimeo.png', {:alt => 'videos from this event', :border => 0, :width => width}), event_path(:id => event) + "#videos")
    end
    
    if event.flickers.empty?
      out += ''
    else
      out += link_to(image_tag('layout/flickr.png', {:alt => 'photos from this event', :border => 0, :width => width}), event_path(:id => event) + "#photos")
    end
    return raw out
  end
  
  def generate_active_cloud
    cloud = []
    cloud += Wikipage.where(:menuize => true)
    cloud += Chatter.where(:menuize => true)
    cloud += Proposal.where(:menuize => true)
    cloud.sort_by{|x| x.updated_at }.reverse.map{|x| raw("<div class=\"active_link\">") + link_to(x.title, [:admin, x]) + raw(" <span class=\"active_type\">[#{x.class.to_s}]</span></div>")}.join('&nbsp;').html_safe
  end
  
  def is_admin_page?
    return true if controller.controller_path =~ /^admin\//
    
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render('admin/wikirevisions/' + association.to_s.singularize + "_fields", :ff => builder)
    end
    link_to_function(name, ("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")) 
  end
    
  def localised_image(source, options = {})
      image_tag("layout/#{I18n.locale}/#{source}", options)
  end
  
  def old_select_tag_for_filter(model, nvpairs, params)
    options = { :query => params[:query] }
    _url = url_for(eval("admin_#{model}_url(options)"))
    _html = %{<label for="show">Show:</label><br />}
    _html << %{<select name="show" id="show"}
    _html << %{onchange="window.location='#{_url}' + '?show=' + this.value">}
    nvpairs.each do |pair|
      _html << %{<option value="#{pair[:scope]}"}
      if params[:show] == pair[:scope] || ((params[:show].nil? || 
  params[:show].empty?) && pair[:scope] == "all")
        _html << %{ selected="selected"}
      end
      _html << %{>#{pair[:label]}}
      _html << %{</option>}
    end
    _html << %{</select>}
    raw _html
  end

  def pageless(total_pages, url=nil)
      opts = {
        :totalPages => total_pages,
        :url        => url,
        :loaderMsg  => 'Loading more results',
        :loaderImage => '/assets/load.gif'
      }

      javascript_tag("$('#results').pageless(#{opts.to_json});")
  end

    
  def ptarmigan_cost(cost, donations = nil)
    if cost == 0
      if donations == true
        t :donations
      else
        t :free
      end
    else 
       number_to_currency(cost, :unit => '&euro;')
    end
  end
  
  def read_more
    if I18n.locale.to_s == 'en'
      return '(read more)'
    elsif I18n.locale.to_s == 'fi'
      return '(lue lisää)'
    else
      return '(read more)'
    end
  end
    
  def to_url(website)
    if website =~ /^http:\/\//
      return website
    else
      return 'http://' + website
    end
  end

  def share_this(item)
    out = "<span class='st_sharethis' st_title='" + item.name + "' st_url='http://#{request.host}" + url_for(item) + "' displayText=''></span><span class='st_facebook' st_title='" + item.name + "' st_url='http://#{request.host}" + url_for(item) + "'  displayText=''></span>"
    out += "<span class='st_digg' st_title='" + item.name + "' st_url='http://#{request.host}" + url_for(item) + "'  displayText=''></span><span class='st_twitter' st_title='" + item.name + "' st_url='http://#{request.host}" + url_for(item) + "'  displayText=''></span>"
    out += "<span class='st_reddit' st_title='" + item.name + "' st_url='http://#{request.host}" + url_for(item) + "'  displayText=''></span><span class='st_plusone' st_title='" + item.name + "' st_url='http://#{request.host}" + url_for(item) + "'  displayText=''></span>"
    out += "<span class='st_email' st_title='" + item.name + "' st_url='http://#{request.host}" + url_for(item) + "'  displayText=''></span>"
    return out.html_safe
  end
  
  
  def twitter_status

    saved_tweet = Cash.where(:source => 'twitter').order(:link_url)
    last_tweet = saved_tweet.first unless saved_tweet.empty?
    now = Time.now.to_i
    if saved_tweet.empty?
      begin
        regex = Regexp.new '((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)'
        twit = Twitter.user_timeline("PtarmiganHki")[0..4]
        # out = [twit.text.gsub( regex, '<a href="\1">\1</a>').gsub(/\@([a-zA-Z0-9_]+)/, '<a href="http://www.twitter.com/#!/\1">@\1</a>'), twit.created_at, twit.id]
      rescue 
        twit =  ['Sorry, can\'t connect to Twitter right now - maybe you can <a href="http://www.twitter.com/hyksos">try</a>.', Time.now, 0]
      end
      twit.each_with_index do |out, index|
        s = Cash.new(:source => 'twitter', :content => out.text.gsub( regex, '<a href="\1">\1</a>').gsub(/\@([a-zA-Z0-9_]+)/, '<a href="http://www.twitter.com/#!/\1">@\1</a>'), :order => out.created_at.to_i, :title => out.id, :link_url => index)
        s.save!
      end
      return Cash.where(:source => 'twitter').order(:link_url)
    elsif now - last_tweet.updated_at.to_i < 930
      return saved_tweet
    else
      begin
        regex = Regexp.new '((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)'
        twit = Twitter.user_timeline("PtarmiganHki")[0..4]
        # out = [twit.text.gsub( regex, '<a href="\1">\1</a>').gsub(/\@([a-zA-Z0-9_]+)/, '<a href="http://www.twitter.com/#!/\1">@\1</a>'), twit.created_at, twit.id]
        if twit.first.id == last_tweet.title
          return twit
        else
          saved_tweet.each{|x| x.destroy }
          twit.each_with_index do |out, index|
            s = Cash.new(:source => 'twitter', :content => out.text.gsub( regex, '<a href="\1">\1</a>').gsub(/\@([a-zA-Z0-9_]+)/, '<a href="http://www.twitter.com/#!/\1">@\1</a>'), :order => out.created_at.to_i, :title => out.id, :link_url => index)
            s.save!
          end
          return Cash.where(:source => 'twitter').order(:link_url)
        end
      rescue 
        return saved_tweet
      end
    end
  end

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end

  # Shortcut for outputing proper ownership of objects,
  # depending on who is looking
  def whose?(user, object)
    case object

      when Post
        owner = object.author
      when Comment
        owner = object.user
      else
        owner = nil
    end
    if user and owner
      if user.id == owner.id
        "his"
      else
        "#{owner.nickname}'s"
      end
    else
      ""
    end
  end

  # Check if object still exists in the database and display a link to it,
  # otherwise display a proper message about it.
  # This is used in activities that can refer to
  # objects which no longer exist, like removed posts.
  def link_to_trackable(object, object_type)
    if object
      if object.respond_to?('name')
        link_to object.name, [:admin, object]
      else 
        link_to object_type.downcase, [:admin, object]
      end
    else
      " which does not exist anymore"
    end
  end

  def trackable_icon(object)
    if object
      if object.icon.respond_to?('url')
        object.icon.url(:thumb)
      else 
        image_path(object.icon)
      end
    else
      image_path('icon_delete.png')
    end
  end

  
end
