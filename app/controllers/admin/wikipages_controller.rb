# -*- encoding : utf-8 -*-
class Admin::WikipagesController < Admin::BaseController
  layout 'staff'
  before_action :load_resource, :only => [:show, :update]
  before_action :load_and_paginate_resources, :only => [:index]
  before_action :authenticate_user!
  has_scope :page, :default => 1
  load_and_authorize_resource
  
  # GET /wikipages
  # GET /wikipages.js
  # GET /wikipages.xml
  # GET /wikipages.json
  def index
    respond_to do |format|
      format.html # index.html.haml
      format.js   # index.js.rjs
      format.xml  { render :xml => @wikipages }
      format.json  { render :json => @wikipages }
    end
  end
  
  # GET /wikipages/:id
  # GET /wikipages/:id.js
  # GET /wikipages/:id.xml
  # GET /wikipages/:id.json
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.js   # show.js.rjs
      format.xml  { render :xml => @wikipages }
      format.json  { render :json => @wikipages }
    end
  end
  
  # GET /wikipages/new
  # GET /wikipages/new.js
  # GET /wikipages/new.xml
  # GET /wikipages/new.json
  def new
    @wikipage = Wikipage.new
    respond_to do |format|
      format.html # new.html.haml
      format.js   # new.js.rjs
      format.xml  { render :xml => @wikipage }
      format.json  { render :json => @wikipage }
    end
  end
  
  # GET /wikipages/:id/edit
  def edit
    @wikipage = Wikipage.find(params[:id])
    @wikirevision = @wikipage.wikirevisions.last || Wikirevision.new

  end
  
  # POST /wikipages
  # POST /wikipages.js
  # POST /wikipages.xml
  # POST /wikipages.json
  def create
    @wikipage = Wikipage.new(params[:wikipage])
    
    respond_to do |format|
      if @wikipage.save
        flash[:notice] = "Wikipage was successfully created."
        format.html { redirect_to(admin_wikipage_path(@wikipage)) }
        format.js   # create.js.rjs
        format.xml  { render :xml => @wikipage, :status => :created, :location => @wikipage }
        format.json  { render :json => @wikipage, :status => :created, :location => @wikipage }
      else
        flash[:error] = "Wikipage could not be created."
        format.html { render 'new' }
        format.js   # create.js.rjs
        format.xml  { render :xml => @wikipage.errors, :status => :unprocessable_entity }
        format.json  { render :json => @wikipage.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /wikipages/:id
  # PUT /wikipages/:id.js
  # PUT /wikipages/:id.xml
  # PUT /wikipages/:id.json
  def update
    respond_to do |format|
      if @wikipage.update_attributes(params[:wikipage])
        flash[:notice] = "Wikipage was successfully updated."
        format.html { redirect_to(@wikipage) }
        format.js   # update.js.rjs
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        flash[:error] = "Wikipage could not be updated."
        format.html { render 'edit' }
        format.js   # update.js.rjs
        format.xml  { render :xml => @wikipage.errors, :status => :unprocessable_entity }
        format.json  { render :json => @wikipage.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /wikipages/:id
  # DELETE /wikipages/:id.js
  # DELETE /wikipages/:id.xml
  # DELETE /wikipages/:id.json
  def destroy
    @wikipage = Wikipage.find(params[:id])
    respond_to do |format|
      if @wikipage.destroy
        flash[:notice] = "Wikipage was successfully destroyed."
        format.html { redirect_to(admin_wikipages_url) }
        format.js   # destroy.js.rjs
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        flash[:error] = "Wikipage could not be destroyed."
        format.html { redirect_to(admin_wikipage_url(@wikipage)) }
        format.js   # destroy.js.rjs
        format.xml  { head :unprocessable_entity }
        format.json  { head :unprocessable_entity }
      end
    end
  end
  
  protected
    
    def collection
      paginate_options ||= {}
      paginate_options[:page] ||= (params[:page] || 1)
      paginate_options[:per_page] ||= (params[:per_page] || 200)
      @collection = @wikipages ||= Wikipage.order('updated_at DESC').page(params[:page]).per(100)
    end
    alias :load_and_paginate_resources :collection
    
    def resource
      if params[:title]
        @resource = @wikipage ||= Wikipage.find_or_create_by_title(params[:title].gsub('_', ' '))
      else
        @resource = @wikipage ||= Wikipage.find(params[:id])
      end
      redirect_to edit_admin_wikipage_path(:id => @wikipage.id) if @wikipage.wikirevisions.empty?
    end
    alias :load_resource :resource
    
end
