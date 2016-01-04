# -*- encoding : utf-8 -*-
class Admin::PostsController < Admin::BaseController
  has_scope :page, :default => 1


  def index
    @posts = Post.by_location(@location.id).page(params[:page]).per(50)
  end
  
  def show
    redirect_to post_path(:id => params[:id])
  end

end
