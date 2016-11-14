class InstancesController < ApplicationController
    
  def show
    title = params[:id]
    @event = Event.friendly.find(params[:event_id])
    if @event.location_id == 3
      @instance = @event.instances.find(params[:id])
      if request.xhr?
        render layout: false
      end
    else
      @instances = @event.instances.to_a.delete_if{|x| x.title.parameterize !~ /#{params[:id]}/ }
      @instance = @instances.first
      set_meta_tags title: @instances.first.title.blank? ? @event.title : @instances.first.title
    end
  end
  
end