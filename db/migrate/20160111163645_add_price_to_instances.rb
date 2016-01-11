class AddPriceToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :price, :float
    add_column :instances, :discounted_price, :float
  end
end
