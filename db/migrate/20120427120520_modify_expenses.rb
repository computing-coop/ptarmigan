# -*- encoding : utf-8 -*-
class ModifyExpenses < ActiveRecord::Migration
  def self.up
    rename_column :expenses, :name, :recipient
    rename_column :expenses, :date, :when
    rename_column :expenses, :expense_type, :what_for
    add_column :expenses, :paid_by, :string
    add_column :expenses, :budgetarea_id, :integer
    add_column :expenses, :has_receipt, :boolean
    add_column :expenses, :location_id, :integer
    execute('delete from expenses')
    rename_column :wikifiles, :wikirevision_id, :wikiattachment_id
    add_column :wikifiles, :wikiattachment_type, :string
    execute('update wikifiles set wikiattachment_type = "Wikirevision"')
  end

  def self.down
    remove_column :expenses, :budgetarea_id
    remove_column :expenses, :paid_by
    remove_column :expenses, :has_receipt
    remove_column :expenses, :location_id
    rename_column :expenses, :what_for, :expense_type
    rename_column :expenses, :when, :date
    rename_column :expenses, :recipient, :name     
    rename_column :wikifiles, :wikiattachment_id, :wikirevision_id
    remove_column :wikifiles, :wikiattachment_type
  end
end
