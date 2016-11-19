# -*- encoding : utf-8 -*-
class CalendarController < ApplicationController
#
#   def index
#     @period = [Time.now.strftime("%Y").to_i, Time.now.strftime('%m').to_i]
#   end
#
#   def update_calendar
#     @period = [params[:year], params[:month]]
#
#     render :layout => false, :template => 'calendar/index'
#   end
# end
  def index
    render_cached_json("cal_" + params[:start] + "_" + params[:end] + "_" + @location.id.to_s, expires_in: 1.hour) do
      events = Event.where(nil)
 
      events = Event.by_location(@location.id).includes(:translations, :instances => :translations, :eventcategories => :translations, :place => :translations).published.between(params['start'], params['end']) if (params['start'] && params['end'])
    
      @events = []
      #if @location.id != 3
   
        @events += events.map(&:instances).flatten.map(&:as_json)
        no_instances = events.to_a.delete_if{|x| !x.instances.empty? }.map(&:as_json)
        # unless no_instances.nil?
       #    @events += no_instances
       #  end
        @events += events.reject{|x| !x.one_day? }
        @events
      # else
  #       @events = events
  #     end
      #
      # respond_to do |format|
      #   format.html # index.html.erb
      #   format.json { render json:  @events}
      # end
     end
  end
  
  def render_cached_json(cache_key, opts = {}, &block)
    opts[:expires_in] ||= 1.day


    expires_in opts[:expires_in], :public => true
    data = Rails.cache.fetch(cache_key, {raw: true}.merge(opts)) do

      block.call.to_json
    end

    render :json => data
  end
  
  
  def show
    @event = Event.friendly.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event }
    end
  end
    
end
