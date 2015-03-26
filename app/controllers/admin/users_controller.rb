# -*- encoding : utf-8 -*-
class Admin::UsersController < InheritedResources::Base
  before_filter :authenticate_user!
  layout 'staff'
  has_scope :page, :default => 1
  load_and_authorize_resource
  def index
    @users = User.all
  end
  
end