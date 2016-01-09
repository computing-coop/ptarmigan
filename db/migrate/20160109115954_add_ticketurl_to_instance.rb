class AddTicketurlToInstance < ActiveRecord::Migration
  def change
    add_column :instances, :ticket_url, :string
  end
end
