class AddPublishedAtToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :published_at, :datetime
    Post.published.each do |p|
      p.published_at = p.updated_at
      p.save(validate: false)
    end
  end
  
  def self.down
    drop_column :posts, :published_at
  end
end
