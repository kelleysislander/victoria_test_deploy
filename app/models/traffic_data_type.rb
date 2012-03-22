class TrafficDataType < ActiveRecord::Base
  
  attr_accessible :name, :description
  
  has_many  :traffic_conditions
  
  validates_presence_of :name, :description
  validates_uniqueness_of :name, :description
  
  validates_length_of :name,        :within => 3..25,   :too_long => "Maximum size for 'Name' is 25.",      :too_short => "Minimum size for 'Name' is 3."
  validates_length_of :description, :within => 5..255,  :too_long => "Maximum size for 'Description' is 255.",  :too_short => "Minimum size for 'Description' is 5."
  
  scope :other, lambda { where("name LIKE 'Other:%'") }
  
  
end
