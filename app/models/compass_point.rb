class CompassPoint < ActiveRecord::Base
  
  has_many  :traffic_conditions
  has_many  :traffic_cameras
  
  validates_presence_of :name, :description
  
  validates_length_of :description, :within => 4..64,  :too_long => "Maximum size for 'Description' is 64.",  :too_short => "Minimum size for 'Description' is 4."
  
end
