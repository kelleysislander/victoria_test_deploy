class AdvertisementType < ActiveRecord::Base
  
  paginates_per 10 # kaminari pagination
  
  has_many :advertisements
  
  validates_presence_of   :advertisement_type, :description
  validates_uniqueness_of :advertisement_type
  
  validates_length_of :advertisement_type, :within => 3..24,  :too_long => "Maximum size for 'Advertisement Type' is 24.",  :too_short => "Minimum size for 'Advertisement Type' is 3."
  validates_length_of :description, :within => 5..512,        :too_long => "Maximum size for 'Description' is 512.",        :too_short => "Minimum size for 'Description' is 5."

end
