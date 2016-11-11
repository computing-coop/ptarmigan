# -*- encoding : utf-8 -*-
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  helper [:applicants, :application, :users]
  helper LaterDude::CalendarHelper
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  theme :get_location
  before_action :get_location
  before_action :get_next_events
  before_action :get_locale
  # before_action :tiib_check
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :scorestore_check
  
  def protect_with_staging_password
    if @subsite.theme == 'creativeterritories'
      authenticate_or_request_with_http_basic('Developer only! (for now)') do |username, password|
        username == 'creative' && password == 'territories'
      end
    end
  end
  
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
  
  def madhouse_list_add
    mailchimp = Mailchimp::API.new(Figaro.env.madhouse_mailchimp_api_key)

    begin
      mailchimp.lists.subscribe(Figaro.env.madhouse_mailchimp_list_id, 
                         { "email" => params[:email] }
                         )

      @signup_success = t("madhouse.thanks_signup")
      @signup_error = nil
    rescue
      @signup_error = t("madhouse.mailchimp_error")
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
    Globalize.fallbacks = {:en => [:en, :et, :fi, :ru, :sv, :lv] , :fi => [:fi, :sv, :en, :et, :ru, :lv],
      et: [:et, :en, :ru, :fi, :sv, :lv], sv:  [:sv, :fi, :en, :et, :ru, :lv], ru:[:ru, :en, :et, :lv, :fi, :sv],
       lv: [:lv, :en, :ru, :et ] }
    if params[:locale]
      session[:locale] = params[:locale]
    end
    available  = %w{en fi et ru lv sv}
    if session[:locale].blank? || !available.include?(session[:locale].to_s)

      I18n.locale = http_accept_language.compatible_language_from(available)
      session[:locale] = I18n.locale
    else
      I18n.locale = session[:locale]
    end

    if @subsite
      if @subsite.name == 'donekino'
        I18n.locale = 'en'
      end

    end

    if @location.id == 4
      unless [:en, :fi, :sv].include?(I18n.locale)
        I18n.locale = 'en'
      end
    end
    
  end 
  
  def get_domain

    if request.host =~ /ptarmigan\.fi/
      @location = Location.where(:locale => 'fi').first

      "fi"
    else
      # hardcode for now
      if request.host =~ /madhouse/
        @location = Location.where(:name => 'Mad House').first
        "madhouse"
      else
        @location = Location.where(:locale => 'fi').first
      
        "ee"
      end
    end

  end

  def get_location
    subsites = Subsite.all.map{|x| x.name.split(/\,/)}.flatten
    toplevel = request.host.match(/^([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*)\./)
    if toplevel.nil?
      toplevel = request.host.match(/^([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*)\./)
    end
    if !toplevel.nil?
      tl =  toplevel[1] == 'www' ? toplevel[2] : toplevel[1]

      if subsites.include?(tl) 

        @subsite = Subsite.all.to_a.delete_if{|x| !x.name.split(/\,/).include?(tl)}.first
        die unless @subsite
        @location = @subsite.location
        protect_with_staging_password
        @subsite.name.split(/\,/).first
        

      else
        get_domain
      end
    else
      get_domain
    end

  end
  
  def get_next_events
    if @location.name == 'Mad House'
      @menu = Page.by_location(@location.id).all
    end
    unless (params[:controller] == 'pages' && params[:action] == 'frontpage')
      @next_events = []
      unless (params[:controller] == 'posts' && params[:action] == 'index' && !params[:page].blank?)
        @next_events = Post.by_location(@location.id).published.news.sticky.order("created_at DESC")
      end
      @next_events += Event.by_location(@location.id).where(["date >= ? AND public is true", Time.now.strftime('%Y-%m-%d')]).order(:date).limit(5)
    end
  end

  def search
    if @location.id < 3
      locations = [1, 2]
    else
      locations = @location.id
    end
    if params[:search].blank?
      @hits = []
      @nosearch = 1
    else
      batch = ThinkingSphinx::BatchedSearch.new
      
      [Artist, Project, Event, Post, Page, Resource].each do |cat|
        batch.searches << cat.search(params[:search], with: { location_id: locations})
      end  
      batch.populate
      @hits = batch.searches.compact.map(&:first).compact

      @searchterm = params[:search]
    end
    render :template => 'shared/searchresults'
  end
  
  protected

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to '/admin'
  end


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

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_OMNIAUTH_APP_ID']
      config.consumer_secret     = ENV['TWITTER_OMNIAUTH_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end  
  end

  
  protected
  
  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs

  end
  
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :slug, :avatar, :password, :remember_token, :remember_created_at, :sign_in_count) }
  #   devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :icon,  :slug, :avatar, :username, :email,  authentications_attributes: [:id, :provider, :username ], role_ids: [] )}
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :slug, :avatar, :name, :username, :password_confirmation, authentications_attributes: [:id, :provider, :username ] ) }
  # end
  def resource_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password)
  end
  private :resource_params
end
