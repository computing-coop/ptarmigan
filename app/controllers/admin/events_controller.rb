# -*- encoding : utf-8 -*-
class Admin::EventsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :find_event
  before_filter :exclude_guests
  layout 'staff'
  EVENTS_PER_PAGE = 100

  # cache_sweeper :event_sweeper, :only => [ :create, :update , :destroy] 
  
  
  def create
    @event = Event.new(params[:event])
    respond_to do |format|
      if @event.save
        # expire_fragment(@event.location.name + '_projects_page')
        flash[:notice] = 'Event was successfully created.'
        format.html { 
          if @event.subsite.name == 'creativeterritories'
            redirect_to admin_events_path
          else
            redirect_to @event
          end
        
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
    if @subsite.name == 'creativeterritories'
      @events = Event.by_subsite(@subsite.id).order('date DESC').page(params[:page])
    else
      @events = Event.order('date DESC').filter(:params => params, :filter => :event_filter)
    end
    respond_to do |format|
      format.html
      format.rss { render :layout => false}
      format.xml  { render :xml => @events }
    end
  end
  
  
  def new
    @event = Event.new(:location_id => @subsite.id, :place_id => nil)
    if @subsite.name == 'creativeterritories'
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
      if @event.update_attributes(params[:event])
        # expire_fragment(@event.location.name + '_projects_page')
        flash[:notice] = 'Event was successfully updated.'
        format.html { 
          if @event.subsite.name == 'creativeterritories'
            redirect_to admin_events_path
          else
            redirect_to @event
          end
        
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
    @event = Event.find(params[:id]) if params[:id]
  end
  
end
