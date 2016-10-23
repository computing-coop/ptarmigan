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
    update! { admin_subsites_path }
  end
  protected


end
