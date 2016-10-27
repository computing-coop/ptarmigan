# -*- encoding : utf-8 -*-
class Admin::SubsitesController < Admin::BaseController
  before_action :authenticate_user!

  respond_to :html, :js, :xml, :json
  layout 'staff'
  has_scope :page, :default => 1
  load_and_authorize_resource
  def create
    create! { admin_subsites_path }
  end
  
  def update
    @subsite = Subsite.find(params[:id])
    if @subsite.update_attributes(subsite_params)
      flash[:notice] = 'Subsite info updated.'
      redirect_to '/admin'
    end
  end
  
  protected

  def subsite_params
    params.require(:subsite).permit([:name, :human_name, :fallback_theme, :location_id, :hide_from_carousel])
  end
end
