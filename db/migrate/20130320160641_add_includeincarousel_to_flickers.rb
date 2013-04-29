# -*- encoding : utf-8 -*-
class AddIncludeincarouselToFlickers < ActiveRecord::Migration
  def change
    add_column :flickers, :include_in_carousel, :boolean
  end
end
