# -*- encoding : utf-8 -*-
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  helper [:applicants, :application, :users]
  helper LaterDude::CalendarHelper
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  theme :get_location
  before_filter :get_location
  before_filter :get_next_events
  before_filter :get_locale
  # before_filter :tiib_check
  # before_filter :scorestore_check
  
  def add_to_mailchimp
    h = Hominid::Base.new({:api_key => MAILCHIMP_API_KEY})
    list = h.find_list_id_by_name("Ptarmigan announcements")
    begin
      h.subscribe(list, params[:email])
      @signup_success = t(:thanks_signup)
      @signup_error = nil
    rescue
      @signup_error = 'There was an error adding your email address, please try again.'
    end
    respond_to do |format|
        format.js {render :partial => 'shared/email_signup', :content_type => 'text/javascript'}
    end
  end

  def exclude_guests
    if user_signed_in?
      if current_user.is_guest?
        flash[:error] = "Sorry, this section is for Ptarmigan staff only."
        redirect_to '/'
      end
    else
      flash[:error] = "Sorry, this section is for Ptarmigan staff only."
      redirect_to '/'
    end
  end

  
  def get_locale 
    if params[:locale]
      session[:locale] = params[:locale]
    end
    
    if session[:locale].blank?
      available  = %w{en fi et ru sv-SE}
      I18n.locale = request.preferred_language_from(available)
    else
      I18n.locale = session[:locale]
    end

    if @subsite
      if @subsite.name == 'donekino'
        I18n.locale = 'en'
      end

    end
  end 
  
  def get_domain

    if request.host =~ /ptarmigan\.fi/
      @location = Location.where(:locale => 'fi').first

      "fi"
    else
      @location = Location.where(:locale => 'ee').first
      
      "ee"
    end
  end

  def get_location
    subsites = Subsite.all.map{|x| x.name}
    toplevel = request.host.match(/^([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\./)
    if !toplevel.nil?
      if subsites.include?(toplevel[1]) 
        @subsite = Subsite.where(:name => toplevel[1]).first
        @location = @subsite.location

        @subsite.name
      else
        get_domain
      end
    else
      get_domain
    end
  end
  
  def get_next_events
    unless (params[:controller] == 'pages' && params[:action] == 'frontpage')
      @next_events = []
      unless (params[:controller] == 'posts' && params[:action] == 'index' && !params[:page].blank?)
        @next_events = Post.by_location(@location.id).published.news.sticky.order("created_at DESC")
      end
      @next_events += Event.where(["date >= ? AND public is true", Time.now.strftime('%Y-%m-%d')]).order(:date).limit(5)
    end
  end

  def search
    if params[:search].blank?
      @hits = []
      @nosearch = 1
    else
      batch = ThinkingSphinx::BatchedSearch.new
      
      [Artist, Project, Event, Post, Page, Resource].each do |cat|
        batch.searches << cat.search(params[:search])
      end  
      batch.populate
      @hits = batch.searches.compact.map(&:first).compact

      @searchterm = params[:search]
    end
    render :template => 'shared/searchresults'
  end
  
  protected
  


  def scorestore_check
    require 'open-uri'
    last_scorestore_update = Cash.where(:source => "scorestore").order("created_at DESC")
    now = Time.now.to_i
    if last_scorestore_update.empty?
      begin
        f = open('http://scorestore.fi/for_ptarmigan.json')
        events = ActiveSupport::JSON.decode(f.first)
      rescue Exception => e
        events = ["error", ['', e.message]]
      end
      events.each do |e|
        s = Cash.new(:source => "scorestore", :title => e.first, :link_url => e.last.first, :content => e.last.last)
        s.save!
      end
      return Cash.where(:source => "scorestore").order("created_at DESC")
    elsif now - last_scorestore_update.first.updated_at.to_i < 10800
      return last_scorestore_update
    else   # been over 3 hrs, so let's see if anything is new
      begin
        f = open('http://scorestore.fi/for_ptarmigan.json')
        events = ActiveSupport::JSON.decode(f.first)
        if events.size == last_scorestore_update.size
          return last_scorestore_update
        else
          last_scorestore_update.each{|x| x.destroy }
          events.each do |e|
            s = Cash.new(:source => "scorestore", :title => e.first, :link_url => e.last.first, :content => e.last.last)
            s.save!
          end
          return Cash.where(:source => "scorestore").order("created_at DESC")      
        end
      rescue
        return last_scorestore_update
      end
    end
  end
  
  
  def tiib_check
    require 'open-uri'
    last_tiib_update = Cash.where(:source => "tiib").order("created_at DESC")
    now = Time.now.to_i
    if last_tiib_update.empty?
      begin
        f = open('http://tiib.net/for_ptarmigan.json')
        events = ActiveSupport::JSON.decode(f.first)
      rescue Exception => e
        events = ["error", ['', e.message]]
      end
      events.each do |e|
        s = Cash.new(:source => "tiib", :title => e.first, :link_url => e.last.first, :content => e.last.last)
        s.save!
      end
      return Cash.where(:source => "tiib").order("created_at DESC")
    elsif now - last_tiib_update.first.updated_at.to_i < 10800
      return last_tiib_update
    else   # been over 3 hrs, so let's see if anything is new
      begin
        f = open('http://tiib.net/for_ptarmigan.json')
        events = ActiveSupport::JSON.decode(f.first)
        if events.size == last_tiib_update.size
          return last_tiib_update
        else
          last_tiib_update.each{|x| x.destroy }
          events.each do |e|
            s = Cash.new(:source => "tiib", :title => e.first, :link_url => e.last.first, :content => e.last.last)
            s.save!
          end
          return Cash.where(:source => "tiib").order("created_at DESC")      
        end
      rescue
        return last_tiib_update
      end
    end
  end
  
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
