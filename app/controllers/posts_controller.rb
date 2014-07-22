# -*- encoding : utf-8 -*-
class PostsController < InheritedResources::Base
  actions :index, :show
  
  def index
    if @subsite
      @posts = Post.by_subsite(@subsite).published.order('created_at DESC').page params[:page]
    else
      @posts = Post.by_location(@location.id).published.order('created_at DESC').page params[:page]
    end
    set_meta_tags :open_graph => {
      :title => "News | Ptarmigan" ,
      :type  => "ptarmigan:news",
      :url   =>  url_for({:only_path => false, :controller => :posts}) },
      :canonical =>  url_for({:only_path => false, :controller => :posts}) ,
      :keywords => 'Helsinki,Finland,Tallinn,Estonia,Ptarmigan,proposals,application,residency,culture,art',
      :description => 'News and other announcements from the Ptarmigan project space.',
      :title => t(:news)

    respond_to do |format|
      format.html
      format.rss { render :layout => false}
      format.xml  { render :xml => @posts }
    end
  end
  
  def witnessed
    @posts = Post.by_location(@location.id).published.not_news.order('created_at DESC').page params[:page]
    render :template => 'posts/index'
  end

 def show
  @post = Post.find(params[:id])
  if request.path != post_path(@post)
    return redirect_to @post, :status => :moved_permanently
  end
  set_meta_tags :open_graph => {
      :title => @post.title,
      :type  => "ptarmigan:news",
      :url   =>  url_for(@post) ,
      :image => (@post.alternateimg? ? 'http://' + request.host + @post.alternateimg.url(:small)  : (@post.carousel? ? 'http://' + request.host +  @post.carousel.url(:small) : 'http://www.ptarmigan.fi/ptarmigan_two_circles.jpg' ))},
      :canonical => url_for(@post),
      :keywords => 'Helsinki,Finland,Tallinn,Estonia,Ptarmigan,proposals,application,residency,culture,art',
      :description => @post.body,
      :title => @post.title
    super
  end
  
  protected

  def collection
    @posts ||= end_of_association_chain.paginate(:page => params[:page])
    @posts = @posts.reverse
  end
       
end
