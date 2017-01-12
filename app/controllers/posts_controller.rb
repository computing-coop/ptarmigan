# -*- encoding : utf-8 -*-
class PostsController < ApplicationController

  
  def index
    if @subsite
      @posts = Post.by_subsite(@subsite).published.order('created_at DESC').page params[:page]
    else
      @posts = Post.by_location(@location.id).published.order('published_at DESC, created_at DESC').page params[:page]
    end
    if @location.id == 4
      set_meta_tags :open_graph => {
        :title => "Mad House Helsinki: " + t("madhouse.latest_news") ,
        :type  => "madhousehelsinki:article",
        image: 'http://madhousehelsinki.fi/assets/madhouse/images/MADHOUSE_4kausi_coverphoto.jpg',
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
        :type  => "ptarmigan:article",
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
    if @location.id == 4
      set_meta_tags :og => {
          :title => @post.title,
          :type  => "madhousehelsinki:article",
          locale: {
            _:  session[:locale] + '_' + (session[:locale].to_s == 'sv' ? 'SE' : session[:locale].upcase)
            
          },
          :url   =>  url_for(@post) ,
          :image => (@post.alternateimg? ?  @post.alternateimg.url(:full)  : (@post.carousel? ?  @post.carousel.url(:medium) : 'http://madhousehelsinki.fi/assets/madhouse/images/MADHOUSE_4kausi_coverphoto.jpg' ))
          },
          :canonical => url_for(@post),
          :keywords => 'Helsinki,Finland,Mad House,performance art,live art,Suvilahti',
          :description => @post.body,
          :title => @post.title
    else
      set_meta_tags :open_graph => {
          :title => @post.title,
          :type  => "ptarmigan:news",
          :url   =>  url_for(@post) ,
          :image => (@post.alternateimg? ? @post.alternateimg.url(:medium)  : (@post.carousel? ?  @post.carousel.url(:medium) : 'http://www.ptarmigan.fi/ptarmigan_two_circles.jpg' ))},
          :canonical => url_for(@post),
          :keywords => 'Helsinki,Finland,Tallinn,Estonia,Ptarmigan,proposals,application,residency,culture,art',
          :description => @post.body,
          :title => @post.title
    end
  
  end
  
  protected

  def collection
    @posts ||= end_of_association_chain.paginate(:page => params[:page])
    @posts = @posts.reverse
  end
       
end
