# -*- encoding : utf-8 -*-
class AddAttachmentToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :attachment_file_name, :string
    add_column :proposals, :attachment_file_size, :integer
    add_column :proposals, :attachment_content_type, :string
    add_column :proposals, :attachment_updated_at, :datetime
  end

  def self.down
    remove_column :proposals, :attachment_updated_at
    remove_column :proposals, :attachment_content_type
    remove_column :proposals, :attachment_file_size
    remove_column :proposals, :attachment_file_name
  end
end
