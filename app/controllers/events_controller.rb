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
      :title => t(:events),
      :type  => "ptarmigan:event",
      :url   => url_for({:only_path => false, :controller => :events, :action => :archive}),
      }, 
      :canonical => url_for({:only_path => false, :controller => :events, :action => :archive}),
      :keywords => (@location.id == 1 ? 'Helsinki,Finland,' : 'Tallinn,Estonia') + ',Ptarmigan,culture,art,' + @archive[0..40].map{|x| x.event_type }.join(':').split(/\s*\:\s*/).compact.uniq.join(','),
      :description => 'Past events',
      :title => t(:events)
      
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @archive }
    end
  end

  def archives
    @archive = Event.by_location(@location.id).where(['public is true AND date < ?', Time.now.to_date]).order(date: :desc).all #page params[:archive_page]
    if @location.id == 4
      
    else
      set_meta_tags :open_graph => {
          :title => t(:events) ,
          :type  => "article",
          :url   => url_for({:only_path => false, :controller => :events}),
          }, 
          :canonical => url_for({:only_path => false, :controller => :events}),
          :keywords => (@location.id == 1 ? 'Helsinki,Finland,' : 'Tallinn,Estonia') + ',Ptarmigan,culture,art,' + @archive.map{|x| x.event_type }.join(':').split(/\s*\:\s*/).compact.uniq.join(','),
          :description => 'Past events',
          :title => t(:events)

      respond_to do |format|
        format.html { render  :template => 'events/index' }
        format.rss { render :layout => false}
        format.xml  { render :xml => @archive }
      end
    end
  end

  def index
    if @location.id == 1
      redirect_to projects_path
    else
      if @subsite
        @upcoming = Event.by_subsite(@subsite).by_location(@location.id).where(['public is true AND date >= ?', Time.now.to_date]).order(:date).page params[:page]
      else
        if @location.id == 4
          @upcoming = Event.primary.published.future.by_location(@location.id).order(:date)
          #@upcoming += Event.one_bar.limit(1)
          @upcoming = @upcoming.sort_by(&:next_date)
          #@upcoming = Kaminari.paginate_array(@upcoming).page(params[:page]).per(8)
          
        else
          @upcoming = Event.by_location(@location.id).where(['date >= ?', Time.now.to_date]).order(:date).page(params[:page]).per(8)
        end
      end
      if @upcoming.size < 7 && !@subsite
        @archive = Event.by_location(@location.id).where(['public is true AND date < ?', Time.now.to_date]).order('date DESC').page params[:archive_page]
      else
        @archive = []
      end

      if @location.id == 4

        set_meta_tags :og => {
          :title => "Mad House Helsinki: " + t("madhouse.upcoming_events") ,
          :type  => "article",
          image: 'https://madhousehelsinki.fi/assets/madhouse/images/MADHOUSE_4kausi_coverphoto.jpg',
          :url   => url_for({:only_path => false, :controller => :events}),
          }, 
          :fb  => {
              :app_id => Figaro.env.madhouse_facebook_client_id
            },
          :canonical => url_for({:only_path => false, :controller => :events}),
          :keywords => 'Mad House,Helsinki,Finland,Suvilahti,culture,art,performance,live art' + @upcoming.map{|x| x.name }.join(','),
          :description => t(:upcoming_events),
          :title => "Mad House Helsinki: "  + t(:events) 
      else
        set_meta_tags :og => {
          :title => t(:events) ,
          :type  => "article",
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


  def secondary
    @location = Location.find(4)
    @upcoming = Event.by_location(@location).ihana.future.published.order(:date).all
    @ihana = true
    render :template => 'events/index'
  end

  def workshops
    @location = Location.find(4)
    @upcoming = Event.by_location(@location).workshop.future.published.order(:date).all

    render :template => 'events/index'
  end

  def show
    find_event
    unless @event.nil?
      if @event.redirect_url.blank? && @location.id == 4
        set_meta_tags :og => {
          :title =>  @event.title  ,
          :type  => "article",
          locale: {
            _:  session[:locale].to_s + '_' + (session[:locale].to_s == 'sv' ? 'SE' : session[:locale].to_s.upcase)
            
          },

          :url   => url_for(@event),

          :image =>  @event.avatar.url(:medium)
          }, 
          :fb  => {
              :app_id => Figaro.env.madhouse_facebook_client_id
            },
          :canonical => url_for(@event), 
          :keywords => 
          ((@event.location.id == 1 || @event.location.id == 4) ? 'Helsinki,Finland,' : 'Tallinn,Estonia') + 'performance,culture,art, ' + 
          (@event.event_type.blank? ? 'Mad House,live art' : @event.event_type.split(/\:/).each(&:strip).join(',')),
          :description => @event.description,
          :title => @event.title
      elsif @event.location_id == 3  && request.xhr?
        render template: 'events/overlay', layout: false
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
