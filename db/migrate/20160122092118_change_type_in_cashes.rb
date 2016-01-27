class ChangeTypeInCashes < ActiveRecord::Migration
 
  def change
    change_column :cashes, :title, :text
    add_column :cashes, :image_file_name, :string
    add_column :cashes, :image_file_size, :integer
    add_column :cashes, :image_content_type, :string
    add_column :cashes, :image_updated_at, :datetime
    add_column :cashes, :image_dimensions, :string
  end

end
