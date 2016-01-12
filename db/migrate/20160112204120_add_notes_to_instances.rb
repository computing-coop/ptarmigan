class AddNotesToInstances < ActiveRecord::Migration
  def change
    add_column :instance_translations, :notes, :text
  end
end
