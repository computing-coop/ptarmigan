class AddSecondembedgalleryidToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :second_embed_gallery_id, :integer
  end
end
