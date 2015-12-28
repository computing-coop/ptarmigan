class CreateLocationPlaces < ActiveRecord::Migration
  def change
    create_join_table :locations, :places
    riga = Location.find_by(:name => 'Riga')
    helsinki = Location.find_by(:name => 'Suomi')
    eesti = Location.find_by(:name => 'Eesti')
    Place.all.each do |p|
      if p.country == 'LV'
        riga.places << p
      elsif p.country == 'Finland'
        helsinki.places << p
      elsif p.country == 'FI'
        helsinki.places << p
      elsif p.country == 'Estonia' || p.country == 'EE'
        eesti.places << p
      end
    end
    
  end
end
