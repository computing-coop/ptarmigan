# -*- encoding : utf-8 -*-
class ModifyIncomes < ActiveRecord::Migration
  def self.up
    rename_column :incomes, :name, :recipient
    rename_column :incomes, :date, :when
    rename_column :incomes, :income_type, :what_for
    add_column :incomes, :source, :string
    add_column :incomes, :budgetarea_id, :integer
    add_column :incomes, :has_receipt, :boolean
    add_column :incomes, :location_id, :integer
    execute('delete from incomes')
  end

  def self.down
    remove_column :incomes, :budgetarea_id
    remove_column :incomes, :source
    remove_column :incomes, :has_receipt
    remove_column :incomes, :location_id
    rename_column :incomes, :what_for, :expense_type
    rename_column :incomes, :when, :date
    rename_column :incomes, :recipient, :name     
  end
end
