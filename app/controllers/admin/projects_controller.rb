# -*- encoding : utf-8 -*-
class Admin::ProjectsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :exclude_guests  
  before_filter :find_project
  layout 'staff'
  has_scope :page, :default => 1
  load_and_authorize_resource
  
  
  
  def create
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to project_url(:id => @project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @project.destroy
        flash[:notice] = 'Project was successfully destroyed.'        
        format.html { redirect_to admin_projects_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Project could not be destroyed.'
        format.html { redirect_to @project }
        format.xml  { head :unprocessable_entity }
      end
    end
  end
  
  def edit
  end
  
  def index
    @projects = Project.order('location_id, id DESC').page(params[:page]).per(50)
    respond_to do |format|
      format.html
      format.rss { render :layout => false}
      format.xml  { render :xml => @projects }
    end
  end
  
  
  def new
    @project = Project.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @project }
    end
  end
  
  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        # expire_fragment(@project.location.name + '_projects_page')
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to project_path(:id => @project.id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    redirect_to edit_admin_project_path(params[:id])
  end
  
  private

  def find_project
    @project = Project.find(params[:id]) if params[:id]
  end
  
end
