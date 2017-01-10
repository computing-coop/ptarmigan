class AddTeaserToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :teaser, :string
    add_column :events, :article_link, :string
  end
end
