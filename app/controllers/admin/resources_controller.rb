# -*- encoding : utf-8 -*-
class Admin::ResourcesController < Admin::BaseController
  # before_filter :authenticate_user!
  # actions :index, :show, :new, :edit, :create, :update, :destroy
  respond_to :html, :js, :xml, :json
  # layout 'staff'
  has_scope :page, :default => 1
  # load_and_authorize_resource
  
  def create
    @resource = Resource.new(resource_params)
    respond_to do |format|
      if @resource.save
        flash[:notice] = 'Document was successfully uploaded.'
        format.html { redirect_to admin_resources_path }
        format.xml  { render :xml => @resource, :status => :created, :location => @resource }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    redirect_to admin_resources_path
  end
  
  def edit
    @resource = Resource.find(params[:id])
  end
  
  def new
    @resource = Resource.new(location_id: @subsite.nil? ? @location.try(:id) : @subsite.try(:id))
  end
  
  def index
    @resources = Resource.by_location(@location.id).order('created_at DESC').page(params[:page])
  end
  
  def update
    @resource = Resource.find(params[:id])
    respond_to do |format|
      if @resource.update_attributes(resource_params)
        flash[:notice] = 'Resource was successfully updated.'
        format.html { redirect_to admin_resources_path  }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  
  protected
  
  def resource_params
    params.require(:resource).permit([:location_id, :name, :description, :project_id, :artist_id, :event_id, :attachment, :icon, :sortorder,
      :all_locations, :press_page, :documenttype_id])
  end
  
end
