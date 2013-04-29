# -*- encoding : utf-8 -*-
class AddHidecarouselToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :hide_carousel, :boolean
  end

  def self.down
    remove_column :posts, :hide_carousel
  end
end
