# -*- encoding : utf-8 -*-
class PagesController < ApplicationController
  include Calendrier::EventExtension
  before_filter :find_page



  def air
    if applicant_in?
      @airforms = Airform.find_all_by_applicant_id(current_applicant.id)
    end
  end
  
  def frontpage
  
    if !@subsite.nil?
      if @subsite.name == 'kuulutused' 
        @places = Place.approved_posters.delete_if{|x| x.votes_against >= 5}
        @json = @places.to_gmaps4rails do |place,marker|
          marker.json({:id => place.id})
        end
      elsif @subsite.name == 'creativeterritories'
        @events = @subsite.events.published
        @events = sort_events(@events)
        @eventcategories = Eventcategory.all
        if params[:month].nil?
          params[:month] = Time.now.month
        end
        if params[:year].nil?
          params[:year] = Time.now.year
        end
        params[:day] = 15
        params[:month] = params[:month].to_i
        params[:year] = params[:year].to_i

      elsif @subsite.name == 'kompass'
        @pages = Page.by_subsite(@subsite)
        @event = @subsite.events.first
        @random_participants = @event.attendees.delete_if{|x| x.profile.blank? }
      else
        @posts = Post.by_subsite(@subsite).published.order('created_at DESC').page params[:page]
      end
    else
      
      
      if @location.name == 'Mad House'
        @upcoming = Event.published.future.by_location(@location.id)
        @carousel = []
        # @carousel =  Flicker.by_location(@location.id).joins(:event).group("events.id")
   
        @posts = Post.by_location(@location.id).published.limit(8)
      
        events = @upcoming.to_a.reject{|x| !x.carousel? }
         events.sort_by{rand}.each do |e|
          @carousel.unshift(e)
        end
        Post.by_location(@location.id).with_carousel.published.each {|x| @carousel.unshift(x) }
        
        # frontpage media cache
        @social_media = Hash.new
        @social_media['twitter'] = Cash.by_location(@location.id).by_source('twitter').order(issued_at: :desc).limit(6)
        @social_media['other'] = Cash.by_location(@location.id).where(["source = ? OR source = ?", 'facebook', 'instagram']).order(issued_at: :desc).limit(10)
        set_meta_tags :open_graph => {
          :title => "Mad House Helsinki",
          :type  => "madhousehelsinki:front",
          image: 'http://madhousehelsinki.fi/assets/madhouse/images/mad_house_box_2016.jpg',
          :url   => 'http://madhousehelsinki.fi'
          }, 
          :fb             => {
              :app_id       => Figaro.env.madhouse_facebook_client_id
            },
          :canonical => 'http://madhousehelsinki.fi',
          :keywords => 'Mad House,Helsinki,Finland,Suvilahti,culture,art,performance,live art',
          :description => 'Mad House is a house for performance and live art in Helsinki. Mad House on räjähdys Suomen esittävän taiteen kentällä. Mad House är en explosion i Finlands performanskonstscen.',
          :title => "Mad House Helsinki" 
        
      else  # it's Ptarmigan - an ugly hack for now but will work
        set_meta_tags :open_graph => {
          :title => (@subsite.nil? ? "" : (@subsite.human_name.blank? ? "#{@subsite.name} | " : "#{@subsite.human_name} | ")) + "Ptarmigan" ,
          :type  => "ptarmigan:article",
          :url   =>   'http://' + (@subsite.nil? ? 'www.' : 'donekino.') + 'ptarmigan.' + @location.locale },
          :canonical =>  'http://www.ptarmigan.' + @location.locale,
          :keywords => 'Helsinki,Finland,Tallinn,Estonia,Ptarmigan,culture,art,workshops,artist-run,project space,maker culture, DIY,experimental, avant-garde, music, sound, visual art,Baltic,residency',
          :description => 'Ptarmigan is a cultural platform in ' + (@location.locale == 'fi' ? "Helsinki, Finland" : "Tallinn, Estonia."),
          :title => nil
        @upcoming = Event.published.future.by_location(@location.id).where(:hide_from_front => false).where("subsite_id is null OR show_on_main = true")
        @new_carousel = Flicker.joins(:event).where(:include_in_carousel => true).where("events.location_id = ?", @location.id).group("events.id")
        @new_carousel = @new_carousel.to_a.sort_by{ rand }[0..5]

        @about = Page.find_by_slug('about')
        @where = Page.where(:slug => 'where').by_location(@location.id).first

        projects = Project.where(:include_in_carousel => true).by_location(@location.id)
        unless projects.empty?
          projects.each {|x| @new_carousel.unshift(x) }
        end

        events = Event.future.by_location(@location.id).to_a.delete_if{|x| !x.carousel? }
        unless events.empty?
          events.sort_by{rand}.each do |e|
            @new_carousel.unshift(e)
          end
        end

        @artist = Artist.by_location(@location.id).current
        unless @artist.empty?
          @new_carousel.unshift(@artist.first)
        end

        Post.by_location(@location.id).with_carousel.published.each {|x| @new_carousel.unshift(x) }
 
        if @subsite
          @posts = Post.by_subsite(@subsite).published.order('sticky DESC, created_at DESC').page(params[:page]).per(1)
        else
          @posts = Post.by_location(@location.id).published.news.order('sticky DESC, created_at DESC').page(params[:page]).per(6)
        end
        @new_carousel = @new_carousel[0..14]
      end
      
      respond_to do |format|
        format.html { render :layout => 'frontpage' }
        format.xml  { render :xml => @page }
      end
    end
  end
  
  def press
    resources = Resource.where(["((location_id is null OR location_id = ?) OR all_locations is true)", @location.id])
    @pagelinks = Presslink.where(["((location_id is null OR location_id = ?) OR all_locations is true)", @location.id]).order("sortorder, presslinks.when DESC")
    @resources = resources.reject{|x| x.press_page != true}
    @other_resources = resources.delete_if{|x| x.item_location != @location}
  end


  def show
    set_meta_tags :open_graph => {
      :title => (@subsite.nil? ? "" : (@subsite.human_name.blank? ? "#{@subsite.name} : " : "#{@subsite.human_name} : ")) + @page.title + " | Ptarmigan" ,
      :type  => "ptarmigan:article",
      :url   =>  url_for(@page)},
      :canonical =>  url_for(@page),
      :keywords => 'Helsinki,Finland,Tallinn,Estonia,Ptarmigan,proposals,application,residency,culture,art',
      :description => @page.description,
      :title => (@subsite.nil? ? "" : (@subsite.human_name.blank? ? "#{@subsite.name} : " : "#{@subsite.human_name} : ")) +  @page.title.humanize
    if params[:id] == 'about' && @subsite.nil?
      @who_we_are = Page.by_location(@location.id).where(:slug => 'who_we_are').first
      @resources = Resource.where(["press_page is true AND ((location_id is null OR location_id = ?) OR all_locations is true)", @location.id])
      @pagelinks = Presslink.where(["((location_id is null OR location_id = ?) OR all_locations is true)", @location.id]).order("sortorder, presslinks.when DESC")
      @contact = Page.where(:slug => 'contact').first
      render :template => 'pages/about'
    else
      respond_to do |format|
        format.html
        format.xml  { render :xml => @page }
      end
    end
  end


  private

  def find_page
    if @subsite.nil?
      @page = Page.where(:slug => params[:id]).where(:location_id => @location.id).where(:subsite_id => nil).first if params[:id]
    else
      if params[:id]
        @page = Page.where(:slug => params[:id]).where(:location_id => @location.id).where(:subsite_id => @subsite.id)
        if @page.blank?
          @page = Page.find(params[:id])
        else
          @page = @page.first
        end
      end  
    end
  end

end
