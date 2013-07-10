class AddHumannameToSubsites < ActiveRecord::Migration
  def change
    add_column :subsites, :human_name, :string
  end
end
