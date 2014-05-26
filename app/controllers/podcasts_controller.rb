# -*- encoding : utf-8 -*-
class PodcastsController < ApplicationController

  before_filter :find_podcast, :except => [:index]
  
  def show
    @podcast = Podcast.find(params[:id])
  end
  
  private
  
  def find_podcast
    @podcast = Podcast.find(params[:id])
  end

end
