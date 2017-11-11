class CreateDoublebills < ActiveRecord::Migration[5.1]
  def self.up
    create_table :doublebills do |t|
      t.references :event
      t.integer :doublebill_id
    end
  end
end
