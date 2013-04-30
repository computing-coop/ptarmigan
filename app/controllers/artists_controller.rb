# -*- encoding : utf-8 -*-
class ArtistsController < ApplicationController

  before_filter :find_artist, :except => [:archive, :index]




  def index
    if @location.id == 1
      redirect_to projects_path
    else  
    @artists = Artist.by_location(@location.id).where(["enddate > ?", Time.now.to_date]).order('enddate DESC').page params[:page]
    @past_artists = Artist.by_location(@location.id).where(["enddate < ?", Time.now.to_date]).order('enddate DESC').page params[:page]

       set_meta_tags :open_graph => {
      :title => 'Artists at Ptarmigan',
      :type  => "ptarmigan:artist",
      :url   => url_for({:only_path => false, :controller => :artists})
      }, 
      :canonical => url_for({:only_path => false, :controller => :artists}),
      :keywords => 'Ptarmigan,Helsinki,Tallinn,culture,art,artists,participation,Finland,Estonia',
      :description => "Ptarmigan works with artist and cultural producer in every event, but we have hosted some longer-term residencies in the past. Here is information about some of the residents we have had.",
      :title => "Artists" 
    respond_to do |format|
      format.html
      format.rss { render :layout => false}
      format.xml  { render :xml => @artists }
    end
  end
end




  def show
     set_meta_tags :open_graph => {
      :title => @artist.name + " | Ptarmigan" ,
      :type  => "ptarmigan:artist",
      :url   => url_for(@artist),
      :image => 'http://' + request.host + @artist.avatar.url(:small)
      }, 
      :canonical => url_for(@artist),
      :keywords => (@artist.location.id == 1 ? 'Helsinki,Finland,' : 'Tallinn,Estonia') + ',Ptarmigan,culture,art,artist,' + @artist.name,
      :description => @artist.description,
      :title => @artist.name    
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @artist }
    end
  end


  private

  def find_artist

    if params[:id] =~ /^\d\d\d\d\-\d{1,2}\-\d{1,2}$/
      @artist = Artist.find_by_date(params[:id])
    elsif params[:id]
      @artist = Artist.find(params[:id])
      if request.path != artist_path(@artist)
        return redirect_to @artist, :status => :moved_permanently
      end  
    end
  end

end
