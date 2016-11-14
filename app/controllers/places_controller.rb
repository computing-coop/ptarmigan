class PlacesController < ActionController::Base
  theme 'kuulutused'
  
  def ctvenues
    @places = Place.events_between(params[:starting], params[:ending]).send(params[:scope])
    render json: @places.to_json
  end
  
  def create
    @place = Place.new(params[:place])
    @place.city = "Tallinn"
    @place.country = 'EE'
    @place.approved_for_posters = true
    if @place.save!
      pv = Postervote.new(:place => @place, :ip_address => request.remote_ip, :vote => 1)
      unless params[:place][:comment].blank?
        pv.comment = params[:place][:comment]
      end
      unless params[:place][:contact_email].blank?
        pv.contact_email = params[:place][:contact_email]
      end
      pv.save!
    end
  end
  
  def show
    @place = Place.find(params[:id])
  end
  
  def new
    @place = Place.new(:city => "Tallinn", :country => 'EE')
  end
  
  def vote
    @place = Place.find(params[:id])
    @place.postervotes << Postervote.create(:ip_address => request.remote_ip, :comment => params[:comment], :vote => params[:vote])
  end
  
end