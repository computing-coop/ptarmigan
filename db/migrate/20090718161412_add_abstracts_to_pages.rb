# -*- encoding : utf-8 -*-
class AddAbstractsToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :abstract_en, :text
    add_column :pages, :abstract_fi, :text
  end

  def self.down
    remove_column :pages, :abstract_fi
    remove_column :pages, :abstract_en
  end
end
