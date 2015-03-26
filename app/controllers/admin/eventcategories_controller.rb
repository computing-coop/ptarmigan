# -*- encoding : utf-8 -*-
class Admin::EventcategoriesController < InheritedResources::Base
  layout 'staff'
  before_filter :authenticate_user!
  load_and_authorize_resource
  def create
    create! { admin_eventcategories_path }
  end
  
  def index
    @eventcategories = Eventcategory.page(params[:page])
  end
  
  def update
    update! { admin_eventcategories_path }
  end
  
end