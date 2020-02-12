# -*- encoding : utf-8 -*-
class Admin::FestivalsController < Admin::BaseController

  def create
    @festival = Festival.new(festival_params)
    if @festival.save
      redirect_to admin_festivals_path
    else
      render template: 'admin/festivals/new'
    end
  end

  def edit
    @festival = Festival.find(params[:id])
    render tempalte: :new
  end

  def new
    @festival = Festival.new
  end

  def index
    @festivals = Festival.all
  end

  def update
    @festival = Festival.find(params[:id])
    if @festival.update(festival_params)
      flash[:notice] = 'The festival was updated.'
      redirect_to admin_festivals_path
    else
      render template: 'admin/festivals/new'
    end
  end
  protected

    def festival_params
      params.require(:festival).permit(:name, :custom_css, :start_at, :end_at,
        translations_attributes: [:description, :id, :locale, :_destroy])
    end
    
end