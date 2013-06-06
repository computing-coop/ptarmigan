class AddEmbedgalleryToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :embed_gallery_id, :integer
    add_column :posts, :embed_above_post, :boolean, :null => false, :default => false
  end
end
