class AddHidefromcarouselToSubsites < ActiveRecord::Migration
  def change
    add_column :subsites, :hide_from_carousel, :boolean
  end
end
