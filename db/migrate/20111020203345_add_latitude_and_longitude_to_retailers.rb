class AddLatitudeAndLongitudeToRetailers < ActiveRecord::Migration
  def change
    add_column :retailers,  :latitude,   :float
    add_column :retailers,  :longitude,  :float
    add_column :retailers,  :zone,       :integer
    
  end
end
