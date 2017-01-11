# -*- encoding : utf-8 -*-
class Admin::ArticlesController < Admin::BaseController
  before_action :find_article


  def create
    @article = Article.new(articles_params)
    @article.location = @location
    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to admin_articles_path  }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @article.destroy
        flash[:notice] = 'Article was successfully destroyed.'        
        format.html { redirect_to admin_articles_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Article could not be destroyed.'
        format.html { redirect_to admin_articles_path}
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    
    @articles = Article.by_location(@location.id) if @articles.nil?
    respond_to do |format|
      format.html
      format.xml  { render :xml => @articles }
    end
  end

  def edit
  end

  def new
    @article = Article.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @article }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @article }
    end
  end

  def update
    @article.location = @location
    respond_to do |format|
      if @article.update_attributes(articles_params)
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to admin_articles_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_article
    @article = Article.find(params[:id]) if params[:id]
  end
  
  protected

  def articles_params 
    params.require(:article).permit(translations_attributes: [:id, :locale, :name, :link_url], location_ids: [])
  end
  
end
