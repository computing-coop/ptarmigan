class AddFileLengthToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :file_length, :integer, :length => 8
  end
end
