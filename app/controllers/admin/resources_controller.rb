# -*- encoding : utf-8 -*-
class Admin::ResourcesController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :index, :show, :new, :edit, :create, :update, :destroy
  respond_to :html, :js, :xml, :json
  layout 'staff'
  has_scope :page, :default => 1
  load_and_authorize_resource
  def index
    @resources = Resource.order('created_at DESC').page(params[:page])
  end
  
end
