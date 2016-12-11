# -*- encoding : utf-8 -*-
class Admin::CtadsController < Admin::BaseController
  before_action :find_ctad


  def create
    @ctad = Ctad.new(ctads_params)
    respond_to do |format|
      if @ctad.save
        flash[:notice] = 'Ad was successfully created.'
        format.html { redirect_to admin_ctads_path  }
        format.xml  { render :xml => @ctad, :status => :created, :location => @ctad }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ctad.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @ctad.destroy
        flash[:notice] = 'Ctad was successfully destroyed.'        
        format.html { redirect_to admin_ctads_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Ctad could not be destroyed.'
        format.html { redirect_to admin_ctads_path}
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index

    @ctads = Ctad.all if @ctads.nil?
    set_meta_tags title: 'Advertisements'
    respond_to do |format|
      format.html
      format.xml  { render :xml => @ctads }
    end
  end

  def edit
  end

  def new
    @ctad = Ctad.new
    if @subsite
      if @subsite.name == 'creativeterritories'
        @ctad.country = 'LV'
      end
    end
    respond_to do |format|
      format.html
      format.xml  { render :xml => @ctad }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @ctad }
    end
  end

  def update
    respond_to do |format|
      if @ctad.update_attributes(ctads_params)
        flash[:notice] = 'Ctad was successfully updated.'
        format.html { redirect_to admin_ctads_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ctad.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_ctad
    @ctad = Ctad.find(params[:id]) if params[:id]
  end
  
  protected

  def ctads_params 
    params.require(:ctad).permit(:name, :link_url, :wide, :boxy, :notes, :active)
  end
  
end
