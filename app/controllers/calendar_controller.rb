# -*- encoding : utf-8 -*-
class CalendarController < ApplicationController
  
  def index
    @period = [Time.now.strftime("%Y").to_i, Time.now.strftime('%m').to_i]
  end
  
  def update_calendar
    @period = [params[:year], params[:month]]
    
    render :layout => false, :template => 'calendar/index'
  end
end
