# -*- encoding : utf-8 -*-
class ProjectsController < ApplicationController
  respond_to :html, :xml, :js 
  before_filter :find_project, :except => [:index, :by_location]


 
  def by_location
    if params[:id] == "0"
      @projects = Project.proposable.active.group(:name).order(:name)
    else
      @projects = Project.by_location(params[:id]).proposable.active
    end
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
  
  def index
    @projects = Project.by_location(@location.id).where(:active => true).order(:name).page(params[:projects_page]).per(5)
    @past_projects = Project.by_location(@location.id).where(:active => false).order(:name).page(params[:past_projects_page]).per(5)
    @artists = Artist.by_location(@location.id).order('enddate DESC').page params[:artists_page]
    @upcoming = Event.by_location(@location.id).future.page params[:events_page]
    @archive = Event.where(['public is true and date < ?', Time.now.to_date]).order('date DESC')

     set_meta_tags :open_graph => {
      :title => 'Projects at Ptarmigan',
      :type  => "ptarmigan:project",
      :url   => url_for({:only_path => false, :controller => :projects})
      }, 
      :canonical => url_for({:only_path => false, :controller => :projects}),
      :keywords => 'Ptarmigan,Helsinki,Tallinn,culture,art,projects,participation,Finland,Estonia',
      :description => "We call Ptarmigan a 'project space' and we like recurring events that can build on existing experiences. Many of our events fall under one or more of these projects. We're always open to proposals for new projects as well as new events under existing themes.",
      :title => "Projects"  
    respond_to do |format|
      format.html 
      format.js
      format.xml  { render :xml => @projects }
    end
  end




  def show
     set_meta_tags :open_graph => {
      :title => @project.name + " | Ptarmigan" ,
      :type  => "ptarmigan:project",
      :url   => url_for(@project),
      :image => 'http://' + request.host + @project.avatar.url(:small)
      }, 
      :canonical => url_for(@project),
      :keywords => (@project.location.id == 1 ? 'Helsinki,Finland,' : 'Tallinn,Estonia') + ',Ptarmigan,culture,art,project,' + @project.name,
      :description => @project.description,
      :title => @project.name
      
    respond_to do |format|
      format.html
      format.xml  { render :xml => @project }
      format.js{ render :layout=>false }
    end
  end



  private

  def find_project
    @project = Project.find(params[:id]) if params[:id]
    if request.path != project_path(@project)
      return redirect_to @project, :status => :moved_permanently
    end  
  end

end
