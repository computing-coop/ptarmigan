# -*- encoding : utf-8 -*-
class Admin::PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_page

  has_scope :page, :default => 1
  layout 'staff'
  
  def create
    @page = Page.new(params[:page])
    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to page_url(:id => @page.slug) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @page.destroy
        flash[:notice] = 'Page was successfully destroyed.'        
        format.html { redirect_to admin_pages_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Page could not be destroyed.'
        format.html { redirect_to @page }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @pages = Page.page(params[:page]).per(50)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @pages }
    end
  end

  def edit
  end

  def new
    @page = Page.new(:location => @location)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @page }
    end
  end

  def show
    redirect_to edit_admin_page_path(@page)
  end

  def update
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to admin_page_path  }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  private

  def find_page
    if params[:id] =~ /^\d+$/
      @page = Page.find(params[:id]) if params[:id]
    else
        @page = Page.find_by_slug(params[:id]) if params[:id]
    end
  end
end
