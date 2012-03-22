class RetailerCategory < ActiveRecord::Base
  
  paginates_per 12 # kaminari pagination
  
  has_many :retailers
  
  validates_presence_of :retailer_category, :description
  
  validates_uniqueness_of :retailer_category
  
  validates_length_of :retailer_category, :within => 3..60,   :too_long => "Maximum size for 'Retailer Category' is 60.", :too_short => "Minimum size for 'Retailer Category' is 3."
  validates_length_of :description,       :within => 5..255,  :too_long => "Maximum size for 'Description' is 255.",      :too_short => "Minimum size for 'Address' is 5."
  
end
