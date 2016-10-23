# -*- encoding : utf-8 -*-
class Admin::AirformsController < Admin::BaseController
  

  respond_to :html, :js, :xml, :json
  before_action :authenticate_user!
  before_action :exclude_guests
  load_and_authorize_resource
  protected
    
    def collection
      paginate_options ||= {}
      paginate_options[:page] ||= (params[:page] || 1)
      paginate_options[:per_page] ||= (params[:per_page] || 200)
      @airforms ||= end_of_association_chain.paginate(paginate_options)
    end
    
  
end
