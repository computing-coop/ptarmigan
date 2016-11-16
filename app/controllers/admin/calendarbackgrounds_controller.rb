# -*- encoding : utf-8 -*-
class Admin::CalendarbackgroundsController < Admin::BaseController



  def create
    @calendarbackground = Calendarbackground.new(calendarbackgrounds_params)
    respond_to do |format|
      if @calendarbackground.save
        flash[:notice] = 'Calendarbackground was successfully created.'
        format.html { redirect_to admin_calendarbackgrounds_path  }
        format.xml  { render :xml => @calendarbackground, :status => :created, :location => @calendarbackground }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @calendarbackground.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @calendarbackground.destroy
        flash[:notice] = 'Calendarbackground was successfully destroyed.'        
        format.html { redirect_to admin_calendarbackgrounds_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Calendarbackground could not be destroyed.'
        format.html { redirect_to admin_calendarbackgrounds_path}
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @calendarbackgrounds = Calendarbackground.all if @calendarbackgrounds.nil?
    respond_to do |format|
      format.html
      format.xml  { render :xml => @calendarbackgrounds }
    end
  end

  def edit
    @calendarbackground = Calendarbackground.find(params[:id])
  end

  def new
    @calendarbackground = Calendarbackground.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @calendarbackground }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @calendarbackground }
    end
  end

  def update
    @calendarbackground = Calendarbackground.find(params[:id])
    respond_to do |format|
      if @calendarbackground.update_attributes(calendarbackgrounds_params)
        flash[:notice] = 'Calendarbackground was successfully updated.'
        format.html { redirect_to admin_calendarbackgrounds_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @calendarbackground.errors, :status => :unprocessable_entity }
      end
    end
  end



  protected

  def calendarbackgrounds_params 
    params.require(:calendarbackground).permit(:active, :image)
  end
  
end
