class CreatePostervotes < ActiveRecord::Migration
  def change
    create_table :postervotes do |t|
      t.references :place
      t.integer :vote
      t.string :ip_address
      t.string :contact_email
      t.text :comment

      t.timestamps
    end
    add_index :postervotes, :place_id
  end
end
