# -*- encoding : utf-8 -*-
class CreateBudgetareas < ActiveRecord::Migration
  def self.up
    create_table :budgetareas do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :budgetareas
  end
end
