# -*- encoding : utf-8 -*-
class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.date :date
      t.string :name
      t.string :expense_type
      t.references :event
      t.float :amount
      t.boolean :hidden

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
