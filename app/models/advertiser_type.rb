class AdvertiserType < ActiveRecord::Base
  
  paginates_per 10 # kaminari pagination
  
  has_many :advertisers
  
  validates_presence_of   :advertiser_type, :description
  validates_uniqueness_of :advertiser_type
  
  validates_length_of :advertiser_type, :within => 3..12,   :too_long => "Maximum size for 'Advertiser Type' is 12.", :too_short => "Minimum size for 'Advertiser Type' is 3."
  validates_length_of :description,     :within => 5..255,  :too_long => "Maximum size for 'Description' is 255.",    :too_short => "Minimum size for 'Address' is 5."
  
end
