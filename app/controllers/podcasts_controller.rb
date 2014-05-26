# -*- encoding : utf-8 -*-
class PodcastsController < ApplicationController

  before_filter :find_podcast, :except => [:index]
  
  def index
    @podcasts = Podcast.published.order('number DESC')
  end
  
  def show
    @podcast = Podcast.find(params[:id])
  end
  

  
  private
  
  def find_podcast
    @podcast = Podcast.find(params[:id])
  end

end
