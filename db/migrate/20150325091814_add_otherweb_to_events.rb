class AddOtherwebToEvents < ActiveRecord::Migration
  def change
    add_column :events, :otherweb, :string
  end
end
