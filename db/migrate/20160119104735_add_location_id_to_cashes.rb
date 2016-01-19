class AddLocationIdToCashes < ActiveRecord::Migration
  def change
    add_column :cashes, :location_id, :integer, null: false, default: 1
    add_column :cashes, :issued_at, :integer, limit: 8
    add_column :cashes, :sourceid, :string
    
  end
end
