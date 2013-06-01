class AddSubsiteIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :subsite_id, :integer
    add_column :posts, :subsite_id, :integer
    add_column :events, :subsite_id, :integer

  end
end
