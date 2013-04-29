# -*- encoding : utf-8 -*-
class RemoveConstraintsOnFlickers < ActiveRecord::Migration
  def self.up
    execute('alter table flickers modify column hostid bigint(20); ')
        execute('alter table flickers modify column creator varchar(255); ')
  end

  def self.down
  end
end
