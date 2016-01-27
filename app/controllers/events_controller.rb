# -*- encoding : utf-8 -*-
class EventsController < ApplicationController
  respond_to :html, :js
  
  def archive
  #  unless read_fragment({:page => params[:page] || 1})
      @archive = Event.where(['public is true and location_id < 3 and date < ?', Time.now.to_date]).order('date DESC')
      @flickers = Flicker.limit(5).order('rand()')
      @videos = Video.limit(3).order('rand()')
      @projects = Project.by_location(@location.id).order(:name).page params[:page]

    set_meta_tags :open_graph => {
      :title => t(:events) + " | Ptarmigan" ,
      :type  => "ptarmigan:event",
      :url   => url_for({:only_path => false, :controller => :events, :action => :archive}),
      }, 
      :canonical => url_for({:only_path => false, :controller => :events, :action => :archive}),
      :keywords => (@location.id == 1 ? 'Helsinki,Finland,' : 'Tallinn,Estonia') + ',Ptarmigan,culture,art,' + @archive[0..40].map{|x| x.event_type }.join(':').split(/\s*\:\s*/).compact.uniq.join(','),
      :description => 'Past events at Ptarmigan',
      :title => t(:events)
      
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @archive }
    end
  end

  def archives
    @archive = Event.by_location(@location.id).where(['public is true AND date < ?', Time.now.to_date]).order('date DESC').page params[:archive_page]
    set_meta_tags :open_graph => {
        :title => t(:events) + " | Ptarmigan" ,
        :type  => "ptarmigan:event",
        :url   => url_for({:only_path => false, :controller => :events}),
        }, 
        :canonical => url_for({:only_path => false, :controller => :events}),
        :keywords => (@location.id == 1 ? 'Helsinki,Finland,' : 'Tallinn,Estonia') + ',Ptarmigan,culture,art,' + @archive.map{|x| x.event_type }.join(':').split(/\s*\:\s*/).compact.uniq.join(','),
        :description => 'Upcoming events at Ptarmigan',
        :title => t(:events)
      respond_to do |format|
        format.html { render  :template => 'events/index' }
        format.rss { render :layout => false}
        format.xml  { render :xml => @archive }
      end
    end

  def index
    if @location.id == 1
      redirect_to projects_path
    else
      if @subsite
        @upcoming = Event.by_subsite(@subsite).by_location(@location.id).where(['public is true AND date >= ?', Time.now.to_date]).order(:date).page params[:page]
      else
        @upcoming = Event.by_location(@location.id).where(['date >= ?', Time.now.to_date]).order(:date).page(params[:page]).per(8)
      end
      if @upcoming.size < 7 && !@subsite
        @archive = Event.by_location(@location.id).where(['public is true AND date < ?', Time.now.to_date]).order('date DESC').page params[:archive_page]
      else
        @archive = []
      end
    
      if @location.id == 4
        set_meta_tags :open_graph => {
          :title => "Mad House Helsinki: " + t("madhouse.upcoming_events") ,
          :type  => "madhouse:event",
          image: 'http://madhousehelsinki.fi/assets/madhouse/images/mad_house_box_2016.jpg',
          :url   => url_for({:only_path => false, :controller => :events}),
          }, 
          :canonical => url_for({:only_path => false, :controller => :events}),
          :keywords => 'Mad House,Helsinki,Finland,Suvilahti,culture,art,performance,live art' + @upcoming.map{|x| x.name }.join(','),
          :description => t(:upcoming_events),
          :title => "Mad House Helsinki: "  + t(:events) 
      else
        set_meta_tags :open_graph => {
          :title => t(:events) ,
          :type  => "ptarmigan:event",
          :url   => url_for({:only_path => false, :controller => :events}),
          }, 
          :canonical => url_for({:only_path => false, :controller => :events}),
          :keywords => ( (@location.id == 1 || @location.id == 4) ? 'Helsinki,Finland,' : 'Tallinn,Estonia') + ',culture,art,Mad House,performance,live art' + @upcoming.map{|x| x.event_type }.join(':').split(/\s*\:\s*/).compact.uniq.join(','),
          :description => t(:upcoming_events),
          :title => t(:events)
      end

      respond_to do |format|
        format.html
        format.js
        format.rss { render :layout => false}
        format.xml  { render :xml => @upcoming }
      end
    end
  end





  def show
    find_event
    unless @event.nil?
      if @event.redirect_url.blank?
        set_meta_tags :open_graph => {
          :title =>  @event.title  ,
          :type  => "ptarmigan:event",
          :url   => url_for(@event),

          :image => 'http://' + request.host + @event.avatar.url(:small)
          }, 
          :canonical => url_for(@event), 
          :keywords => 
          ((@event.location.id == 1 || @event.location.id == 4) ? 'Helsinki,Finland,' : 'Tallinn,Estonia') + 'performance,culture,art, ' + 
          (@event.event_type.blank? ? 'Mad House,live art' : @event.event_type.split(/\:/).each(&:strip).join(',')),
          :description => @event.description,
          :title => @event.title
      elsif request.original_url != @event.redirect_url
        if @subsite || @event.subsite
          redirect_to @event.redirect_url 
        end
      end
    end
  end


  private


  def find_event
    if params[:id] =~ /^\d\d\d\d\-\d{1,2}\-\d{1,2}$/
      @events = Event.has_events_on(params[:id])
      @tiib = Cash.tiib_events_on(params[:id])
      @datespan = params[:id]
    else
      @event = Event.friendly.find(params[:id])
      unless @event.flickers.empty?
          require 'flickraw'
      end
      if request.path != event_path(@event) && @event.redirect_url.blank?
        return redirect_to @event, :status => :moved_permanently
      end
    end
  end


end
