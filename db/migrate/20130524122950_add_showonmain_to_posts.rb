class AddShowonmainToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :show_on_main, :boolean
    add_column :events, :show_on_main, :boolean
    add_column :pages, :carousel_file_name, :string
    add_column :pages, :carousel_file_size, :integer
    add_column :pages, :carousel_content_type, :string
    add_column :pages, :carousel_updated_at, :datetime
  end
end
