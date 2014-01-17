class AddStickyToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sticky, :boolean, :null => false, :default => false
    add_column :posts, :alternateimg_file_name, :string
    add_column :posts, :alternateimg_file_size, :integer, length: 8
    add_column :posts, :alternateimg_content_type, :string
    add_column :posts, :alternateimg_updated_at, :datetime
  end
end
