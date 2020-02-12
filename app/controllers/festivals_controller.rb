class FestivalsController < ApplicationController

  def show
    @festival = Festival.friendly.find(params[:id])
    render layout: @festival.slug, template: 'festivals/' + @festival.slug
  end

end