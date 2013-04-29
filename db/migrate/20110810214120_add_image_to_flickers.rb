# -*- encoding : utf-8 -*-
class AddImageToFlickers < ActiveRecord::Migration
  def self.up
    add_column :flickers, :image_file_name, :string
    add_column :flickers, :image_file_size, :integer
    add_column :flickers, :image_updated_at, :datetime
    add_column :flickers, :image_content_type, :string
  end

  def self.down
    remove_column :flickers, :image_content_type
    remove_column :flickers, :image_updated_at
    remove_column :flickers, :image_file_size
    remove_column :flickers, :image_file_name
  end
end
