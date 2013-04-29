class CreateDocumenttypes < ActiveRecord::Migration
  def change
    create_table :documenttypes do |t|
      t.string :name
      t.timestamps
    end
    execute("insert into documenttypes (name) values ('Bank/financial/tax statement')")
    execute("insert into documenttypes (name) values ('Event poster')")
    execute("insert into documenttypes (name) values ('Event-related document (non-poster)')")
    execute("insert into documenttypes (name) values ('Funding application')")    
    execute("insert into documenttypes (name) values ('Funding report')")
    execute("insert into documenttypes (name) values ('Internal document')")
    execute("insert into documenttypes (name) values ('Invitation letter')")    
    execute("insert into documenttypes (name) values ('Invoice issued')")
    execute("insert into documenttypes (name) values ('Invoice received')")
    execute("insert into documenttypes (name) values ('Logos, letterheads, etc.')")     
    execute("insert into documenttypes (name) values ('Other letter')")     
    execute("insert into documenttypes (name) values ('Press or external writing')") 
    execute("insert into documenttypes (name) values ('Publication')")
    execute("insert into documenttypes (name) values ('Other')")
      
    add_column :wikifiles, :documenttype_id, :integer
    add_column :resources, :documenttype_id, :integer

    execute("update resources set documenttype_id = 2")
    execute("update resources set documenttype_id = 3 where id in (10, 14)")
    execute("update resources set documenttype_id = 13 where id IN (15, 16, 17, 18, 19, 20, 28)")
    execute("update resources set documenttype_id = 14 where id = 21 ")
    execute("update wikifiles set documenttype_id = 8 where wikiattachment_type = 'Income'")
    execute("update wikifiles set documenttype_id = 9 where wikiattachment_type = 'Expense'")
    execute("update wikifiles set documenttype_id = 1 where id >= 93 AND id <= 103")
    execute("update wikifiles set documenttype_id = 1 where id IN (25, 26, 69, 108)")
    execute("update wikifiles set documenttype_id = 7 where id IN (104, 105, 106, 107, 116 )")
    execute("update wikifiles set documenttype_id = 4 where id IN (55, 58, 60, 62, 61, 63, 64)")
    execute("update wikifiles set documenttype_id = 5 where id IN (23, 24, 112)")
    execute("update wikifiles set documenttype_id = 6 where id IN (54, 67, 68)")    



  end
end
