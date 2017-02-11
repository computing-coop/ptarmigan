class Admin::CarouselvideosController < Admin::BaseController
  
  def create
    @carouselvideo = Carouselvideo.create(carouselvideo_params)
    respond_with @carouselvideo, location: admin_carouselvideos_path
  end
  
  def index
    @carouselvideos = Carouselvideo.by_location(@location.id).page(params[:page]).per(50)
  end
  
  def edit
    @carouselvideo = Carouselvideo.find(params[:id])

  end
  
  def new
    @carouselvideo = Carouselvideo.new(location_id: @location.id)
  end
  
  def update
    @carouselvideo = Carouselvideo.find(params[:id])
    if @carouselvideo.update_attributes(carouselvideo_params) 
      flash[:notice] = 'Carousel video was successfully updated.'
      redirect_to admin_carouselvideos_path
    end
  end
  
  def destroy
    @carouselvideo = Carouselvideo.find(params[:id])
    @carouselvideo.destroy!
    flash[:notice] = 'Carousel video was successfully deleted.'
    redirect_to admin_carouselvideos_path
  end
  
  private
  
  def carouselvideo_params
    params.require(:carouselvideo).permit(:video_url, :link_url, :stillimage, :published, :location_id, :subsite_id,
      translation_attributes: [:id, :locale, :title, :subtitle])
  end
  
end