# -*- encoding : utf-8 -*-
class Admin::AttendeesController < Admin::BaseController
  has_scope :event
  load_and_authorize_resource
  has_scope :page, :default => 1
  
  respond_to :html, :js, :xml, :json
  layout 'staff', :only => [:index, :edit]
  before_filter :authenticate_user!, :only => [:index, :destroy, :edit]
  def create
    @attendee = Attendee.create(params[:attendee])
    if @attendee.save
      render :text => 'Thank you for registering.  You will receive an email in the next few days to confirm.'
    end      
  end
  
  def edit
    edit! { admin_attendees_path }
  end

  def show
    @attendee = Attendee.find(params[:id])
    redirect_to '/admin/attendees?event=' + @attendee.event.id.to_s 
  end

  # protected
    
  #   def collection
  #     paginate_options ||= {}
  #     paginate_options[:page] ||= (params[:page] || 1)
  #     paginate_options[:per_page] ||= (params[:per_page] || 200)
  #     @attendees ||= end_of_association_chain.page(paginate_options)
  #   end
        
end
