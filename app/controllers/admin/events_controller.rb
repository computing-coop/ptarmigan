# -*- encoding : utf-8 -*-
class Admin::EventsController < Admin::BaseController
  
  before_filter :find_event
  # before_filter :exclude_guests
  EVENTS_PER_PAGE = 100

  # cache_sweeper :event_sweeper, :only => [ :create, :update , :destroy] 
  
  
  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        # expire_fragment(@event.location.name + '_projects_page')
        flash[:notice] = 'Event was successfully created.'
        format.html { 
            redirect_to admin_events_path
        }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @event.destroy
        flash[:notice] = 'Event was successfully destroyed.'        
        format.html { redirect_to admin_events_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Event could not be destroyed.'
        format.html { redirect_to @event }
        format.xml  { head :unprocessable_entity }
      end
    end
  end
  
  def edit
  end
  
  def index
    if @subsite
     if @subsite.name == 'creativeterritories'
        @events = Event.by_subsite(@subsite.id).order('date DESC').page(params[:page])
      else
        @events = Event.page(params[:page]).per(50).order('date DESC')
      end
    else
      if @location.name == 'Mad House'
        @events = Event.by_location(@location.id).page(params[:page]).per(50).order('date DESC')
      else
        @events = Event.page(params[:page]).per(50).order('date DESC')
      end
    end
    respond_to do |format|
      format.html
      format.rss { render :layout => false}
      format.xml  { render :xml => @events }
    end
  end
  
  
  def new

    @event = Event.new(:location_id => @subsite.nil? ? @location.try(:id) : @subsite.try(:id), :place_id => nil)
    if @subsite && @subsite.name == 'creativeterritories'
      @event.location_id = 3
      @event.subsite_id = 5
    end
    respond_to do |format|
      format.html
      format.xml  { render :xml => @event }
    end
  end
  
  def update
    respond_to do |format|
      if @event.update_attributes(event_params)
        # expire_fragment(@event.location.name + '_projects_page')
        flash[:notice] = 'Event was successfully updated.'
        format.html { 
            redirect_to admin_events_path
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    redirect_to edit_admin_event_path(params[:id])
  end
  private

  def find_event
    @event = Event.friendly.find(params[:id]) if params[:id]
  end
  
  protected
  
  def event_params
     params.require(:event).permit( [:date, :promoter, :event_type, :cost, :metadata, :notes, :avatar, :public, :enddate, 
      :discountedcost, :project_id, :discountreason, :facebook, :registration_required, :registration_limit, :location_id,
      :place_id, :registration_recipient, :registration_optional_q, :featured, :hide_from_front, :carousel, 
      :donations_requested, :hide_registrants, :slug, :subsite_id, :show_on_main, :show_guests_to_public, :ticket_url,
      :require_approval, :redirect_url, :otherweb, :event_time,
      eventcategory_ids: [],
      translations_attributes: [:title, :description, :notes, :id, :locale, :_destroy]])
  end
    

end
