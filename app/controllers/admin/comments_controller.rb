# -*- encoding : utf-8 -*-
class Admin::CommentsController < InheritedResources::Base
  layout 'staff'
  before_filter :authenticate_user!
  before_filter :find_chatter

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
