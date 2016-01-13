class Admin::CalendarController < Admin::BaseController

  def index
    events = Event.where(nil)
    events = Event.between(params['start'], params['end']) if (params['start'] && params['end'])
    @events = []
    @events += events.map(&:instances).flatten
    @events += events.reject{|x| !x.one_day? }
    @events.delete_if {|x| !x.instances.empty? }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events }
    end
  end
  
  def show
    @event = Event.friendly.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event }
    end
  end
    
end
