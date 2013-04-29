# -*- encoding : utf-8 -*-
class AddIncludeInCarouselToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :include_in_carousel, :boolean
    add_column :projects, :include_in_carousel, :boolean
  end
end
