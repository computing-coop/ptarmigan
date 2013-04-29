# -*- encoding : utf-8 -*-
class AttendeesController < InheritedResources::Base
  
  actions :index, :show, :new, :edit, :create, :update, :destroy
  respond_to :html, :js, :xml, :json
   before_filter :authenticate_user!, :only => [:destroy]

  def check
    attendee = Attendee.where(:event_id => params[:event_id], :email => params[:email])
    @event = Event.find(params[:event_id])
    if attendee.empty?
      @result = :no_one_registered
    else
      @result = :yes_you_are_registered
    end
    render :format => :js   
  end

  def create
    @attendee = Attendee.new(params[:attendee])

    if verify_recaptcha(:model => @attendee, :message => "Oh! It's error with reCAPTCHA!") && @attendee.save 

      render :format => :js
    end      
  end
  
  def destroy
    destroy! { admin_attendees_path }
  end
  
  protected
    
    def collection
      paginate_options ||= {}
      paginate_options[:page] ||= (params[:page] || 1)
      paginate_options[:per_page] ||= (params[:per_page] || 20)
      @attendees ||= end_of_association_chain.paginate(paginate_options)
    end
        
end
