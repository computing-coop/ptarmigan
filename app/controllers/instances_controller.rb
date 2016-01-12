class InstancesController < ApplicationController
  
  
  def show
    title = params[:id]
    @event = Event.friendly.find(params[:event_id])
    @instances = @event.instances.to_a.delete_if{|x| x.title.parameterize !~ /#{params[:id]}/ }
    @instance = @instances.first
    set_meta_tags title: @instances.first.title
  end
  
end