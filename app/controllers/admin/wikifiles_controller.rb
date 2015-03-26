# -*- encoding : utf-8 -*-
class Admin::WikifilesController < InheritedResources::Base
  before_filter :authenticate_user!
  layout 'staff'
  load_and_authorize_resource
end
