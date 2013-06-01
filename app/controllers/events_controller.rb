# -*- encoding : utf-8 -*-
class EventsController < ApplicationController

  def archive
  #  unless read_fragment({:page => params[:page] || 1})
      @archive = Event.where(['public is true and date < ?', Time.now.to_date]).order('date DESC')
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
        @upcoming = Event.by_location(@location.id).where(['public is true AND date >= ?', Time.now.to_date]).order(:date).page params[:page]
      end
      if @upcoming.size < 7 && !@subsite
        @archive = Event.by_location(@location.id).where(['public is true AND date < ?', Time.now.to_date]).order('date DESC').page params[:archive_page]
      else
        @archive = []
      end

      set_meta_tags :open_graph => {
        :title => t(:events) + " | Ptarmigan" ,
        :type  => "ptarmigan:event",
        :url   => url_for({:only_path => false, :controller => :events}),
        }, 
        :canonical => url_for({:only_path => false, :controller => :events}),
        :keywords => (@location.id == 1 ? 'Helsinki,Finland,' : 'Tallinn,Estonia') + ',Ptarmigan,culture,art,' + @upcoming.map{|x| x.event_type }.join(':').split(/\s*\:\s*/).compact.uniq.join(','),
        :description => 'Upcoming events at Ptarmigan',
        :title => t(:events)

      respond_to do |format|
        format.html
        format.rss { render :layout => false}
        format.xml  { render :xml => @upcoming }
      end
    end
  end





  def show
    find_event
    unless @event.nil?
      set_meta_tags :open_graph => {
        :title =>  @event.title + " | Ptarmigan" ,
        :type  => "ptarmigan:event",
        :url   => url_for(@event),

        :image => 'http://' + request.host + @event.avatar.url(:small)
        }, 
        :canonical => url_for(@event), 
        :keywords => 
        (@event.location.id == 1 ? 'Helsinki,Finland,' : 'Tallinn,Estonia') + ',Ptarmigan,culture,art, ' + 
        (@event.event_type.blank? ? '' : @event.event_type.split(/\:/).each(&:strip).join(',')),
        :description => @event.description,
        :title => @event.title
    end
  end


  private


  def find_event
    if params[:id] =~ /^\d\d\d\d\-\d{1,2}\-\d{1,2}$/
      @events = Event.has_events_on(params[:id])
      @tiib = Cash.tiib_events_on(params[:id])
      @datespan = params[:id]
    else
      @event = Event.find(params[:id], :include => [:flickers, :videos])
      unless @event.flickers.empty?
          require 'flickraw'
      end
      if request.path != event_path(@event)
        return redirect_to @event, :status => :moved_permanently
      end
    end
  end


end
