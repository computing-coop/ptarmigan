# -*- encoding : utf-8 -*-
class PodcastsController < ApplicationController

  before_filter :find_podcast, :except => [:index]
  
  def index
    @podcasts = Podcast.published.order('number DESC')
  end
  
  def show
    @podcast = Podcast.find(params[:id])
    set_meta_tags :og => {
        :title => "Podcast: " + @podcast.name,
        :type  => "ptarmigan:podcast",
        :image => @podcast.event.nil? ? false : "http://ptarmigan.ee" + @podcast.event.avatar.url(:small),
        :url   =>  url_for(@podcast) },

        :canonical => url_for(@podcast),
        :keywords => 'Tallinn,Estonia,Ptarmigan,podcasts,discussion,art,dialogue,social practice',
        :description => @podcast.description,
        :title => "Podcast: " + @podcast.name


  end
  

  
  private
  
  def find_podcast
    @podcast = Podcast.find(params[:id])
  end

end
