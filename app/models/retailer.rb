class Retailer < ActiveRecord::Base
  
  paginates_per 10 # kaminari pagination
  
  has_many    :deals
  has_many    :advertisements
  has_many    :advertisers, :through => :deals
  has_many    :advertisers, :through => :advertisements
  
  belongs_to  :retailer_category
  belongs_to  :account
  
  RegPat = /^\s*[-+]?\d+\.\d+\,\s?[-+]?\d+\.\d+\s*$/
  
  validates_presence_of :retailer_category_id, :name, :address, :phone, :contact_name, :contact_email
  validates_presence_of [ :city, :state ], :if => lambda{ |obj| (obj.address =~ RegPat) != 0 }, :message => "and Country required if the Address was not a Lat / Lng coordinate pair"
  validates_uniqueness_of :name, :scope => :address
  
  validates_presence_of [:latitude, :longitude], :message => 'cannot be blank; the lat / long coordinates are acquired by supplying a valid address'
  
  validates_length_of :name,    :within => 5..255,  :too_long => "Maximum size for 'Name' is 255.",     :too_short => "Minimum size for 'Name' is 5."
  validates_length_of :address, :within => 5..255,  :too_long => "Maximum size for 'Address' is 255.",  :too_short => "Minimum size for 'Address' is 5."
  validates_length_of :city,    :within => 5..255,  :too_long => "Maximum size for 'City' is 255.",     :too_short => "Minimum size for 'City' is 5.",    
    :if => lambda{ |obj| (obj.address =~ RegPat) != 0 } # City and Country required if the Address was not a Lat / Lng coordinate pair
  validates_length_of :state,   :within => 2..255,  :too_long => "Maximum size for 'Country' is 255.",  :too_short => "Minimum size for 'Country' is 2.", 
    :if => lambda{ |obj| (obj.address =~ RegPat) != 0 } # City and Country required if the Address was not a Lat / Lng coordinate pair
    
  # validates_length_of :zip,     :within => 5..10,   :too_long => "Maximum size for 'Zip' is 10.",       :too_short => "Minimum size for 'Name' is 5."

  before_save  :get_zone
  
  def reset_coordinates
    self.latitude   = nil
    self.longitude  = nil
  end
  
  def full_street_address
    "#{address} #{city} #{state}"
  end
  
  # Retailer.get_zone
  def get_zone
    zone = Map.which_zone?( [self.latitude,  self.longitude] )
    zone ||= 0
    self.zone = zone
  end
  
  # NOTE: geocoding is handled in the form via a google maps api call
  geocoded_by :full_street_address    # can also be an IP address
  # Conditionally reset coordinates and geocode
  # before_validation :reset_coordinates,     # conditionally null out latitude / longitude so we can tell afterwards by their presence if the after_validation :geocode worked correctly
  #   :if => lambda{ |obj| obj.address_changed? || obj.city_changed? || obj.state_changed? || obj.zip_changed? }
  # after_validation :geocode,
  #   :if => lambda{ |obj| obj.address_changed? || obj.city_changed? || obj.state_changed? || obj.zip_changed? || obj.latitude == nil || obj.longitude == nil}

  # before_validation :reset_coordinates      # null out latitude / longitude so we can tell afterwards if the after_validation :geocode worked correctly
  # after_validation  :geocode                # auto-fetch coordinates

  scope :has_lat_long, lambda { where('latitude IS NOT NULL AND longitude IS NOT NULL') }
  scope :has_active_deals, lambda { where( "(retailers.deals.beg_date <= '#{Date.today.to_s}' AND retailers.deals.end_date >= '#{Date.today.to_s}') AND retailers.deals.active_flag = 1" )}
  scope :name_search, lambda{ |param| p = "%#{query.downcase}%"; { :conditions => ['lower(retailers.name) LIKE ?', p] } }
  
  # scope :recent, lambda { where('published_at >= ?', Time.now - 1.week) }
  
end # class

=begin

relationship between advertisements, retailers, and advertisers:

SELECT
  a.retailer_id as advertiser_retailer_id,
  advment.retailer_id as advertisement_retailer_id,
  advment.advertiser_id as advertisement_advertiser_id,
  advment.name as advertisement_name,
--  a.name as advertiser_name,
  IFNULL(a.name, r.name) as advertiser,
  r.name as retailer_name,
  CASE 
    WHEN a.retailer_id IS NULL
    THEN 'N' 
    ELSE 'Y' 
  END as "advertiser_is_retailer?"
FROM advertisements advment
JOIN retailers r ON r.id = advment.retailer_id
JOIN advertisers a ON a.id = advment.advertiser_id
LEFT JOIN retailers r_as_a ON r_as_a.id = advment.retailer_id;

=end
