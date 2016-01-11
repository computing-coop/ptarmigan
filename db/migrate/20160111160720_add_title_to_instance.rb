class AddTitleToInstance < ActiveRecord::Migration
  def change
    add_column :instances, :title, :string
  end
end
