
class AddDimensionsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :carousel_dimensions, :string
    add_column :posts, :alternateimg_dimensions, :string
    add_column :events, :avatar_dimensions, :string
    add_column :events, :carousel_dimensions, :string
    add_column :flickers, :image_dimensions, :string
  end
end
