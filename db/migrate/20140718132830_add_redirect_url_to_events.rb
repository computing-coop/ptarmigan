class AddRedirectUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :redirect_url, :string
  end
end
