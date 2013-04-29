# -*- encoding : utf-8 -*-
class CreateIncome < ActiveRecord::Migration
  def self.up
    create_table :incomes do |t|
      t.date :date
      t.string :name
      t.string :income_type
      t.references :event
      t.float :amount
      t.boolean :hidden

      t.timestamps
    end
  end

  def self.down
    drop_table :incomes
  end
end
