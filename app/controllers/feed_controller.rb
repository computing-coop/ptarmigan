# -*- encoding : utf-8 -*-
class FeedController < ApplicationController
  respond_to :rss

  def index
    @feed = []
    @feed += Event.published.order('date desc').limit(30)
    @feed += Post.published.where(["created_at >= ?", @feed.last.feed_date]).order('created_at').limit(20)
    @feed += Podcast.published.order('number desc').limit(10)
    @feed = @feed.sort_by{|x| x.feed_date}
    
    @feed.reverse!

    @feed = @feed[0..25]
    @feed = @feed.sort_by{|x| x.created_at}.reverse
  end

end
