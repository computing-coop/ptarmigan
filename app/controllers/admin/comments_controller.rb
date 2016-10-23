# -*- encoding : utf-8 -*-
class Admin::CommentsController < Admin::BaseController
  layout 'staff'
  before_action :authenticate_user!
  before_action :find_chatter
  load_and_authorize_resource
  layout 'staff'
  EVENTS_PER_PAGE = 20
  
  def create 
    create! { admin_chatter_path(@comment.chatter) }
  end
  
  private

  def find_chatter
    @chatter = Chatter.find(params[:id]) if params[:id]
  end
end
