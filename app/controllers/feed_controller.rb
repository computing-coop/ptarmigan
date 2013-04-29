# -*- encoding : utf-8 -*-
class FeedController < ApplicationController
  respond_to :rss

  def index
    @feed = []
    @feed += Event.published.order(:date).limit(20)
    @feed += Post.published.limit(20)
    @feed = @feed.sort_by{|x| x.feed_date}
    @feed.reverse!
    @feed = @feed[0..19]

  end

end
