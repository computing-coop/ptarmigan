# -*- encoding : utf-8 -*-
class Admin::PresslinksController < Admin::BaseController
  before_action :authenticate_user!

  respond_to :html, :js, :xml, :json
  layout 'staff'
  has_scope :page, :default => 1
  load_and_authorize_resource
  def create 
    create! { admin_presslinks_path }
  end
  
  def update
    update! { admin_presslinks_path }
  end


        
end
