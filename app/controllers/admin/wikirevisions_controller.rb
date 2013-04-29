# -*- encoding : utf-8 -*-
class Admin::WikirevisionsController < ApplicationController
  layout 'staff'
  before_filter :load_resource, :only => [:show, :edit, :update, :destroy]
  before_filter :load_and_paginate_resources, :only => [:index]
  before_filter :authenticate_user!
  
  # GET /wikirevisions
  # GET /wikirevisions.js
  # GET /wikirevisions.xml
  # GET /wikirevisions.json
  def index
    respond_to do |format|
      format.html # index.html.haml
      format.js   # index.js.rjs
      format.xml  { render :xml => @wikirevisions }
      format.json  { render :json => @wikirevisions }
    end
  end
  
  # GET /wikirevisions/:id
  # GET /wikirevisions/:id.js
  # GET /wikirevisions/:id.xml
  # GET /wikirevisions/:id.json
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.js   # show.js.rjs
      format.xml  { render :xml => @wikirevisions }
      format.json  { render :json => @wikirevisions }
    end
  end
  
  # GET /wikirevisions/new
  # GET /wikirevisions/new.js
  # GET /wikirevisions/new.xml
  # GET /wikirevisions/new.json
  def new
    @wikirevision = Wikirevision.new
    # @wikirevision.wikifiles << Wikifile.new
    respond_to do |format|
      format.html # new.html.haml
      format.js   # new.js.rjs
      format.xml  { render :xml => @wikirevision }
      format.json  { render :json => @wikirevision }
    end
  end
  
  # GET /wikirevisions/:id/edit
  def edit
    @wikipage = Wikipage.find_by_title(params[:title])
  end
  
  # POST /wikirevisions
  # POST /wikirevisions.js
  # POST /wikirevisions.xml
  # POST /wikirevisions.json
  def create
    pa = params[:wikirevision]

    watts = pa[:wikifiles_attributes] if params[:wikirevision][:wikifiles_attributes]
    pa.delete :wikifiles_attributes

    @wikirevision = Wikirevision.new(pa) 
    respond_to do |format|
      if @wikirevision.save
        if watts
          watts.each do |wa|
            if wa.last['id']
              wf = Wikifile.find(wa.last['id'])
              if wa.last['_destroy'] == "1"
                wf.destroy
              else
                @wikirevision.wikifiles << wf
                wf.save!
              end
            elsif wa.last['attachment']

              # wa.last[:wikirevision_id] = @wikirevision.id

              wf = Wikifile.new(wa.last)
              wf.save!
              @wikirevision.wikifiles << wf
              @wikirevision.save!
            end
          end

        else
          logger.warn('no dice' + params[:wikirevision].inspect)
        end
        flash[:notice] = "Wikirevision was successfully created."
        format.html { redirect_to '/admin/wiki/' + @wikirevision.wikipage.title.gsub(/\s/, '_') }
        format.js   # create.js.rjs
        format.xml  { render :xml => @wikirevision, :status => :created, :location => @wikirevision }
        format.json  { render :json => @wikirevision, :status => :created, :location => @wikirevision }
      else
        flash[:error] = "Wikirevision could not be created."
        @wikipage = @wikirevision.wikipage
        format.html { render :template => 'admin/wikipages/edit'}
        format.js   # create.js.rjs
        format.xml  { render :xml => @wikirevision.errors, :status => :unprocessable_entity }
        format.json  { render :json => @wikirevision.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /wikirevisions/:id
  # PUT /wikirevisions/:id.js
  # PUT /wikirevisions/:id.xml
  # PUT /wikirevisions/:id.json
  def update
  create
  end
  
  # DELETE /wikirevisions/:id
  # DELETE /wikirevisions/:id.js
  # DELETE /wikirevisions/:id.xml
  # DELETE /wikirevisions/:id.json
  def destroy
    respond_to do |format|
      if @wikirevision.destroy
        flash[:notice] = "Wikirevision was successfully destroyed."
        format.html { redirect_to(wikirevisions_url) }
        format.js   # destroy.js.rjs
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        flash[:error] = "Wikirevision could not be destroyed."
        format.html { redirect_to(wikirevision_url(@wikirevision)) }
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
      paginate_options[:per_page] ||= (params[:per_page] || 20)
      @collection = @wikirevisions ||= Wikirevision.page(params[:page]).per(20)
    end
    alias :load_and_paginate_resources :collection
    
    def resource
      @resource = @wikirevision ||= Wikirevision.find(params[:id])
    end
    alias :load_resource :resource
    
end
