class Admin::InstancesController < Admin::BaseController

  def create
    @event = Event.friendly.find(params[:event_id])
    @event.instances << Instance.new(instance_params)
    if @event.save
      respond_with @event, location: -> { admin_events_path }
    end
  end
  
  def edit
    @event = Event.friendly.find(params[:event_id])
    @instance = @event.instances.find(params[:id])\
  end
  
  def destroy
    @event = Event.friendly.find(params[:event_id])
    @instance = @event.instances.find(params[:id])
    if @instance.destroy
      respond_with @event, location: -> { admin_events_path }
    end
  end
  
  def index
    redirect_to admin_events_path
  end
  
  def new
    @event = Event.friendly.find(params[:event_id])
    @instance = Instance.new(event: @event)
  end
  
  def update
    @event = Event.friendly.find(params[:event_id])
    @instance = @event.instances.find(params[:id])
    if @instance.update_attributes(instance_params)
      respond_with @event, location: -> { admin_events_path }
    end
  end

  protected
  
  def instance_params
    params.require(:instance).permit([:start_at, :end_at, :ticket_url, :specialimage, :place_id, :title, :event_id, :price, :discounted_price, :remove_specialimage, translations_attributes:[:id, :locale, :special_information, :notes, :_delete]])
  end

end