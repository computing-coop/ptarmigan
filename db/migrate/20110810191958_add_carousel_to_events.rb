# -*- encoding : utf-8 -*-
class AddCarouselToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :carousel_file_name, :string
    add_column :events, :carousel_file_size, :integer
    add_column :events, :carousel_content_type, :string
    add_column :events, :carousel_updated_at, :datetime
    add_column :projects, :carousel_file_name, :string
    add_column :projects, :carousel_file_size, :integer
    add_column :projects, :carousel_content_type, :string
    add_column :projects, :carousel_updated_at, :datetime
    add_column :posts, :carousel_file_name, :string
    add_column :posts, :carousel_file_size, :integer
    add_column :posts, :carousel_content_type, :string
    add_column :posts, :carousel_updated_at, :datetime
    add_column :artists, :carousel_file_name, :string
    add_column :artists, :carousel_file_size, :integer
    add_column :artists, :carousel_content_type, :string
    add_column :artists, :carousel_updated_at, :datetime            
  end

  def self.down
    remove_column :events, :carousel_updated_at
    remove_column :events, :carousel_content_type
    remove_column :events, :carousel_file_size
    remove_column :events, :carousel_file_name
    remove_column :projects, :carousel_updated_at
    remove_column :projects, :carousel_content_type
    remove_column :projects, :carousel_file_size
    remove_column :projects, :carousel_file_name
    remove_column :posts, :carousel_updated_at
    remove_column :posts, :carousel_content_type
    remove_column :posts, :carousel_file_size
    remove_column :posts, :carousel_file_name    
    remove_column :artists, :carousel_updated_at
    remove_column :artists, :carousel_content_type
    remove_column :artists, :carousel_file_size
    remove_column :artists, :carousel_file_name
  end
end
