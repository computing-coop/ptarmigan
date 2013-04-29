# -*- encoding : utf-8 -*-
class AirformsController < InheritedResources::Base
  
  actions :index, :show, :new, :edit, :create, :update, :destroy
  respond_to :html, :js, :xml, :json
  
  before_filter :applicant_required
  
  def submit
    @airform = Airform.find(params[:id])
    if current_applicant != @airform.applicant
      flash[:error] = "This is not your application to submit!"
      redirect_to('/air')
    else
      @airform.submitted = true
      if @airform.save!
        redirect_to '/airforms/submitted'
      end
    end
  end
  
  def edit
    @airform = Airform.find(params[:id])
    if @airform.applicant != current_applicant
      flash[:error] = 'This is not your application to edit!'
      redirect_to('/air#myapps')
    end
    unless @airform.can_edit?
      redirect_to @airform
    end
  end
  
  
  def submitted
  end
  
  def new
    @airform = Airform.find(:all, :conditions => ['applicant_id = ? ', current_applicant.id])
    if !@airform.blank?
      redirect_to '/air#myapps'
    else
      @airform = Airform.new
    end
  end
  
  def index
    redirect_to '/air'
  end
  
  protected
    
    def collection
      paginate_options ||= {}
      paginate_options[:page] ||= (params[:page] || 1)
      paginate_options[:per_page] ||= (params[:per_page] || 20)
      @airforms ||= end_of_association_chain.paginate(paginate_options)
    end
        
end
