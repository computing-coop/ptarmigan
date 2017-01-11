# -*- encoding : utf-8 -*-
class Admin::RadiolinksController < Admin::BaseController
  before_action :find_radiolink


  def create
    @radiolink = Radiolink.new(radiolinks_params)
    @radiolink.location = @location
    respond_to do |format|
      if @radiolink.save
        flash[:notice] = 'Radiolink was successfully created.'
        format.html { redirect_to admin_radiolinks_path  }
        format.xml  { render :xml => @radiolink, :status => :created, :location => @radiolink }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @radiolink.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @radiolink.destroy
        flash[:notice] = 'Radiolink was successfully destroyed.'        
        format.html { redirect_to admin_radiolinks_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Radiolink could not be destroyed.'
        format.html { redirect_to admin_radiolinks_path}
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    
    @radiolinks = Radiolink.by_location(@location.id) if @radiolinks.nil?
    respond_to do |format|
      format.html
      format.xml  { render :xml => @radiolinks }
    end
  end

  def edit
  end

  def new
    @radiolink = Radiolink.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @radiolink }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @radiolink }
    end
  end

  def update
    @radiolink.location = @location
    respond_to do |format|
      if @radiolink.update_attributes(radiolinks_params)
        flash[:notice] = 'Radiolink was successfully updated.'
        format.html { redirect_to admin_radiolinks_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @radiolink.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_radiolink
    @radiolink = Radiolink.find(params[:id]) if params[:id]
  end
  
  protected

  def radiolinks_params 
    params.require(:radiolink).permit(:link_url, translations_attributes: [:id, :locale, :name], location_ids: [])
  end
  
end
