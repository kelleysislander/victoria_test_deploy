class TrafficCamera < ActiveRecord::Base
  
  attr_accessible :name, :address, :latitude, :longitude, :status, :geocode_flag, :url, :compass_point_id
  
  paginates_per 8 # kaminari pagination

  has_many  :traffic_conditions
  has_many  :traffic_condition_historicals
  
  belongs_to  :compass_point
  
  validates_presence_of :name, :address, :status, :geocode_flag, :status
  validates_presence_of :compass_point_id
  
  validates_uniqueness_of :name #, :scope => :address
  validates_uniqueness_of :url
  
  validates_length_of :name,    :within => 5..255,  :too_long => "Maximum size for 'Name' is 255.",     :too_short => "Minimum size for 'Name' is 5."
  validates_length_of :address, :within => 5..255,  :too_long => "Maximum size for 'Address' is 255.",  :too_short => "Minimum size for 'Address' is 5."
  validates_length_of :url,     :within => 5..255,  :too_long => "Maximum size for 'URL' is 255.",      :too_short => "Minimum size for 'URL' is 5."
  
  scope :has_lat_long, lambda { where('latitude IS NOT NULL AND longitude IS NOT NULL') }
  scope :active, lambda { where('status = 1') }
  
  geocoded_by :address    # can also be an intersection

  StatusFlags = [
    # Displayed     stored in DB
    [ "Active",         1  ],
    [ "Inactive",       0  ]
  ]

  GeocodeFlags = [
    # Displayed     stored in DB
    [ "No",             0     ],
    [ "Yes",            1     ]
  ]
  def reset_coordinates
    self.latitude   = nil
    self.longitude  = nil
  end

  # Geocode Flag is to turn on/off geocoding by address in the event that the user supplies the lat/long coordinates
  validates_presence_of :address, :if => Proc.new {|obj| obj.geocode_flag == 1}, :message => "required if 'Geocode?' is set to 'Yes'"
  # Conditionally geocode 
  validates_presence_of [:latitude, :longitude], :if => Proc.new {|obj| obj.geocode_flag == 0}, :message => "cannot be blank if 'Geocode by Address?' is set to 'No'; the Latitude and Longitude coordinates are required"
  validates_presence_of [:latitude, :longitude], :if => Proc.new {|obj| obj.geocode_flag == 1}, :message => "cannot be blank if 'Geocode by Address?' is set to 'Yes'; the Latitude and Longitude coordinates are acquired by supplying a valid address"
  # validates_presence_of [:latitude, :longitude], :if => Proc.new {|obj| obj.geocode_flag == 0 || obj.address.blank?}, :message => "required if 'Geocode?' is set to 'No' or 'Address' is blank"

  # NOTE: geocoding is done via ajax in the traffic_camera/_form.html.haml script
  # Conditionally reset coordinates and geocode
  # before_validation :reset_coordinates,     # conditionally null out latitude / longitude so we can tell afterwards by their presence if the after_validation :geocode worked correctly
  #   :if => lambda{ |obj| obj.address_changed? && obj.geocode_flag == 1 }
  # after_validation :geocode,
  #   :if => lambda{ |obj| (obj.address_changed? || obj.latitude == nil || obj.longitude == nil) && obj.geocode_flag == 1 }
  
end

=begin
NOTE: The "Other" traffic_camera record is for traffic alerts coming from a source Other Than an actual traffic camera.  This may be an eyewitness report, a tweet, etc
central expressway intersection haskell ave dallas, tx
central expressway intersection fitzhugh ave dallas, tx
central expressway intersection knox st dallas, tx
central expressway intersection mockingbird ln dallas, tx
central expressway intersection lovers ln dallas, tx
central expressway intersection northwest hwy dallas, tx
central expressway intersection park ln dallas, tx
central expressway intersection walnut hill ln dallas, tx
central expressway intersection royal ln dallas, tx
central expressway intersection forest ln dallas, tx

=end