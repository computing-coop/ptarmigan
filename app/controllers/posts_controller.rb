# -*- encoding : utf-8 -*-
class PostsController < InheritedResources::Base
  actions :index, :show
  
  def index
    if @subsite
      @posts = Post.by_subsite(@subsite).published.order('created_at DESC').page params[:page]
    else
      @posts = Post.by_location(@location.id).published.order('published_at DESC, created_at DESC').page params[:page]
    end
    if @location.id == 4
      set_meta_tags :open_graph => {
        :title => "Mad House Helsinki: " + t("madhouse.latest_news") ,
        :type  => "madhouse:posts",
        image: 'http://madhousehelsinki.fi/assets/madhouse/images/mad_house_box_2016.jpg',
        :url   => url_for({:only_path => false, :controller => :posts}),
        }, 
        :fb             => {
            :app_id       => Figaro.env.madhouse_facebook_client_id
          },
        :canonical => url_for({:only_path => false, :controller => :posts}),
        :keywords => 'Mad House,Helsinki,Finland,Suvilahti,culture,art,performance,live art',
        :description => t("madhouse.latest_news"),
        :title => "Mad House Helsinki: "  + t("madhouse.latest_news") 
    else
      set_meta_tags :open_graph => {
        :title => "News | Ptarmigan" ,
        :type  => "ptarmigan:news",
        :url   =>  url_for({:only_path => false, :controller => :posts}) },
        :canonical =>  url_for({:only_path => false, :controller => :posts}) ,
        :keywords => 'Helsinki,Finland,Tallinn,Estonia,Ptarmigan,proposals,application,residency,culture,art',
        :description => 'News and other announcements from the Ptarmigan project space.',
        :title => t(:news)
    end


    respond_to do |format|
      format.html
      format.js
      format.rss { render :layout => false}
      format.xml  { render :xml => @posts }
    end
  end
  
  def witnessed
    @posts = Post.by_location(@location.id).published.not_news.order('created_at DESC').page params[:page]
    render :template => 'posts/index'
  end

 def show
  @post = Post.friendly.find(params[:id])
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
