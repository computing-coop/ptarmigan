# -*- encoding : utf-8 -*-
class AddNotnewsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :not_news, :boolean, :default => false, :null => false
  end
end
