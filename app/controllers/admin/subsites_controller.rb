# -*- encoding : utf-8 -*-
class Admin::SubsitesController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :index, :show, :new, :edit, :create, :update, :destroy
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
