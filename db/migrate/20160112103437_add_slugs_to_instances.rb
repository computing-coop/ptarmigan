class AddSlugsToInstances < ActiveRecord::Migration
  def self.up
    add_column :instances, :slug, :string
    Instance.find_each(&:save)
  end
  
  def self.down
    drop_column :instances, :slug
  end
end
