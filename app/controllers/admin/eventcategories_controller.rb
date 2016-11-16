# -*- encoding : utf-8 -*-
class Admin::EventcategoriesController < Admin::BaseController



  def create
    @eventcategory = Eventcategory.new(eventcategories_params)
    respond_to do |format|
      if @eventcategory.save
        flash[:notice] = 'Eventcategory was successfully created.'
        format.html { redirect_to admin_eventcategories_path  }
        format.xml  { render :xml => @eventcategory, :status => :created, :location => @eventcategory }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @eventcategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @eventcategory = Eventcategory.friendly.find(params[:id])
    respond_to do |format|
      if @eventcategory.destroy
        flash[:notice] = 'Eventcategory was successfully destroyed.'        
        format.html { redirect_to admin_eventcategories_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Eventcategory could not be destroyed.'
        format.html { redirect_to admin_eventcategories_path}
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @eventcategories = Eventcategory.all
    respond_to do |format|
      format.html
      format.xml  { render :xml => @eventcategories }
    end
  end

  def edit
    @eventcategory = Eventcategory.friendly.find(params[:id])
  end

  def new
    @eventcategory = Eventcategory.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @eventcategory }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @eventcategory }
    end
  end

  def update
    @eventcategory = Eventcategory.friendly.find(params[:id])
    respond_to do |format|
      if @eventcategory.update_attributes(eventcategories_params)
        flash[:notice] = 'Eventcategory was successfully updated.'
        format.html { redirect_to admin_eventcategories_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @eventcategory.errors, :status => :unprocessable_entity }
      end
    end
  end



  protected

  def eventcategories_params 
    params.require(:eventcategory).permit(:colour, translations_attributes: [:id, :locale, :name])
  end
  
end
