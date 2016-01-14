class CreateJoinTablePostPostcategory < ActiveRecord::Migration
  def change
    create_join_table :posts, :postcategories do |t|
      # t.index [:post_id, :postcategory_id]
      # t.index [:postcategory_id, :post_id]
    end
  end
end
