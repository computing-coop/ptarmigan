class Admin::BaseController < ApplicationController
  layout 'staff'
  before_action :authenticate_user!
  respond_to :html
  #load_and_authorize_resource
  # check_authorization
  # skip_before_filter :require_no_authentication

  def check_permissions
    authorize! :create, resource
  end
  

end
