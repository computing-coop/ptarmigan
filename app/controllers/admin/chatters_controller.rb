# -*- encoding : utf-8 -*-
class Admin::ChattersController < Admin::BaseController
  layout 'staff'
  before_action :authenticate_user!
  load_and_authorize_resource
  
  def index
    @chatters = Chatter.includes(:comments).sort_by{|x| x.latest }.reverse
  end
  
end
