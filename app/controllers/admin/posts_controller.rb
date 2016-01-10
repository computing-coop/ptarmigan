# -*- encoding : utf-8 -*-
class Admin::PostsController < Admin::BaseController
  has_scope :page, :default => 1

  def create
    @post = Post.create(post_params)
    respond_with @post, location: admin_posts_path
  end

  def edit
    @post = Post.friendly.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def index
    @posts = Post.by_location(@location.id).order('published_at DESC, created_at DESC').page(params[:page]).per(50)
  end
  
  def show
    redirect_to post_path(:id => params[:id])
  end
  
  def update
    @post = Post.friendly.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(post_params)
        # expire_fragment(@event.location.name + '_projects_page')
        flash[:notice] = 'Post was successfully updated.'
        format.html { 
            redirect_to admin_posts_path
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
    
  protected
  
  def post_params
    params.require(:post).permit([:user_id, :location_id, :published, :is_personal, :carousel, :hide_carousel, :slug, :not_news,
        :subsite_id, :show_on_main, :published_at, :embed_gallery_id, :embed_above_post, :second_embed_gallery_id, :sticky,
        :alternateimg, translations_attributes: [:id, :locale, :post_id, :body, :title]])
  end
end
