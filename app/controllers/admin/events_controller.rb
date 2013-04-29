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
        format.html { redirect_to event_url(:id => @event) }
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
    @events = Event.filter(:params => params, :filter => :event_filter)  #.order('date DESC').page(params[:page]).per(50)
    respond_to do |format|
      format.html
      format.rss { render :layout => false}
      format.xml  { render :xml => @events }
    end
  end
  
  
  def new
    @event = Event.new(:location => @location, :place_id => nil)
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
        format.html { redirect_to event_path(:id => @event.id) }
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
