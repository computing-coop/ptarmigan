# -*- encoding : utf-8 -*-
class Admin::UsersController < Admin::BaseController
  before_action :authenticate_user!
  layout 'staff'
  has_scope :page, :default => 1
  load_and_authorize_resource
  def index
    @users = User.all
  end
  
end