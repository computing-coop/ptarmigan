# -*- encoding : utf-8 -*-
class AttendeesController < ApplicationController
  
  # actions :index, :show, :new, :create, :update
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
  
  def index
    unless params[:event_id]
      flash[:error] = 'You can only view attendees of a specific event, not all.'
      redirect_to '/'
    else
      @event = Event.friendly.find(params[:event_id])
      if @event.show_guests_to_public == false && !user_signed_in?
        flash[:error] = 'This event does not publicise the attendee list.'
        redirect_to '/'
      else
        @attendees = @event.attendees
      end
    end
  end

  def destroy
    destroy! { admin_attendees_path }
  end
  
  protected
    

end
