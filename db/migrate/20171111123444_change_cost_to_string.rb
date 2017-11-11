class ChangeCostToString < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :cost, :string
    add_column :events, :video_link, :string
  end
end
